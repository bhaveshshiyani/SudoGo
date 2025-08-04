import 'dart:convert';
import 'dart:math';

import 'package:SudoGo/bloc/sudoku_event.dart';
import 'package:SudoGo/bloc/sudoku_state.dart';
import 'package:bloc/bloc.dart';
import 'package:uuid/uuid.dart';

import '../database/database.dart';

class SudokuBloc extends Bloc<SudokuEvent, SudokuState> {
  final SudokuDatabase database;

  // The solved version of the board. Generated dynamically.
  late List<List<int>> _solvedBoard;
  // The initial puzzle board. Generated dynamically.
  late List<List<int>> _initialBoard;

  SudokuBloc({required this.database}) : super(SudokuInitial()) {
    on<NewGameEvent>(_onNewGame);
    on<CellTappedEvent>(_onCellTapped);
    on<NumberSelectedEvent>(_onNumberSelected);
    on<ClearCellEvent>(_onClearCell);
    on<LoadGameEvent>(_onLoadGame);
    on<ResetGameEvent>(_onResetGame);
  }

  void _onLoadGame(LoadGameEvent event, Emitter<SudokuState> emit) async {
    final savedGame = await database.getMostRecentGame();
    if (savedGame != null) {
      // Decode saved boards from JSON strings
      _initialBoard = (jsonDecode(savedGame.initialBoard) as List)
          .map((row) => List<int>.from(row.cast<int>()))
          .toList();
      final currentBoard = (jsonDecode(savedGame.currentBoard) as List)
          .map((row) => List<int>.from(row.cast<int>()))
          .toList();
      _solvedBoard = (jsonDecode(savedGame.solvedBoard) as List)
          .map((row) => List<int>.from(row.cast<int>()))
          .toList();

      emit(SudokuLoaded(
        board: currentBoard,
        initialBoard: _initialBoard,
        selectedRow: -1,
        selectedCol: -1,
        isSolved: false,
        invalidCells: _validateBoard(currentBoard),
        gameId: savedGame.id,
      ));
    } else {
      // If no saved game, start a new one
      add(NewGameEvent());
    }
  }

  void _onNewGame(NewGameEvent event, Emitter<SudokuState> emit) async {
    // Generate a new solved board.
    _solvedBoard = _generateSolvedBoard();

    // Create a deep copy of the solved board to create the puzzle.
    _initialBoard = _solvedBoard.map((row) => List<int>.from(row)).toList();
    _removeNumbersFromBoard(_initialBoard, 40); // Remove 40 numbers for a medium difficulty.

    // Create a new board from the initial board to allow modification.
    final newBoard = _initialBoard.map((row) => List<int>.from(row)).toList();

    // Generate a unique ID for the new game
    final newGameId = const Uuid().v4();

    // Save the new game to local database
    await database.saveGame(newGameId, newBoard, _initialBoard, _solvedBoard);

    emit(SudokuLoaded(
      board: newBoard,
      initialBoard: _initialBoard,
      selectedRow: -1,
      selectedCol: -1,
      isSolved: false,
      invalidCells: List.generate(9, (_) => List.filled(9, false)),
      gameId: newGameId,
    ));
  }

  void _onResetGame(ResetGameEvent event, Emitter<SudokuState> emit) async {
    if (state is SudokuLoaded) {
      final loadedState = state as SudokuLoaded;

      // Reset the board to its initial state
      final newBoard = loadedState.initialBoard.map((row) => List<int>.from(row)).toList();

      // Update the existing game in the database
      await database.updateGame(loadedState.gameId, newBoard);

      emit(loadedState.copyWith(
        board: newBoard,
        isSolved: false,
        invalidCells: _validateBoard(newBoard),
      ));
    }
  }

  void _onCellTapped(CellTappedEvent event, Emitter<SudokuState> emit) {
    if (state is SudokuLoaded) {
      final loadedState = state as SudokuLoaded;

      // Only allow selection of non-pre-filled cells
      if (loadedState.initialBoard[event.row][event.col] == 0) {
        emit(loadedState.copyWith(
          selectedRow: event.row,
          selectedCol: event.col,
        ));
      } else {
        // Deselect any previously selected cell if a pre-filled one is tapped
        emit(loadedState.copyWith(
          selectedRow: -1,
          selectedCol: -1,
        ));
      }
    }
  }

  void _onNumberSelected(NumberSelectedEvent event, Emitter<SudokuState> emit) async {
    if (state is SudokuLoaded) {
      final loadedState = state as SudokuLoaded;

      // Check if a cell is selected and it's not a pre-filled cell.
      if (loadedState.selectedRow != -1 &&
          loadedState.selectedCol != -1 &&
          loadedState.initialBoard[loadedState.selectedRow]
          [loadedState.selectedCol] ==
              0) {
        // Create a new board to maintain immutability.
        final newBoard = loadedState.board
            .map((row) => List<int>.from(row))
            .toList();
        newBoard[loadedState.selectedRow][loadedState.selectedCol] =
            event.number;

        final newInvalidCells = _validateBoard(newBoard);
        final isSolved = _checkIfSolved(newBoard);

        if (isSolved) {
          await database.deleteGame(loadedState.gameId);
        } else {
          await database.updateGame(loadedState.gameId, newBoard);
        }

        emit(loadedState.copyWith(
          board: newBoard,
          isSolved: isSolved,
          invalidCells: newInvalidCells,
        ));
      }
    }
  }

  bool _checkIfSolved(List<List<int>> currentBoard) {
    // Check if the current board matches the solved board.
    for (int i = 0; i < 9; i++) {
      for (int j = 0; j < 9; j++) {
        if (currentBoard[i][j] != _solvedBoard[i][j]) {
          return false;
        }
      }
    }
    return true;
  }
  void _onClearCell(ClearCellEvent event, Emitter<SudokuState> emit) async {
    if (state is SudokuLoaded) {
      final loadedState = state as SudokuLoaded;

      // Check if a cell is selected and it's not a pre-filled cell.
      if (loadedState.selectedRow != -1 &&
          loadedState.selectedCol != -1 &&
          loadedState.initialBoard[loadedState.selectedRow]
          [loadedState.selectedCol] ==
              0) {
        // Create a new board to maintain immutability.
        final newBoard = loadedState.board
            .map((row) => List<int>.from(row))
            .toList();
        newBoard[loadedState.selectedRow][loadedState.selectedCol] = 0;

        final newInvalidCells = _validateBoard(newBoard);
        final isSolved = _checkIfSolved(newBoard);

        if (isSolved) {
          await database.deleteGame(loadedState.gameId);
        } else {
          await database.updateGame(loadedState.gameId, newBoard);
        }

        emit(loadedState.copyWith(
          board: newBoard,
          isSolved: isSolved,
          invalidCells: newInvalidCells,
        ));
      }
    }
  }

  // --- Sudoku Board Generation and Validation Logic ---

  List<List<bool>> _validateBoard(List<List<int>> board) {
    final invalidCells = List.generate(9, (_) => List.filled(9, false));

    // Check rows and columns
    for (int i = 0; i < 9; i++) {
      Set<int> rowNumbers = {};
      Set<int> colNumbers = {};
      for (int j = 0; j < 9; j++) {
        if (board[i][j] != 0) {
          if (rowNumbers.contains(board[i][j])) {
            // Find all instances of this duplicate in the row and mark them invalid.
            for (int k = 0; k < 9; k++) {
              if (board[i][k] == board[i][j]) {
                invalidCells[i][k] = true;
              }
            }
          }
          rowNumbers.add(board[i][j]);
        }

        if (board[j][i] != 0) {
          if (colNumbers.contains(board[j][i])) {
            // Find all instances of this duplicate in the column and mark them invalid.
            for (int k = 0; k < 9; k++) {
              if (board[k][i] == board[j][i]) {
                invalidCells[k][i] = true;
              }
            }
          }
          colNumbers.add(board[j][i]);
        }
      }
    }

    // Check 3x3 subgrids
    for (int boxRow = 0; boxRow < 3; boxRow++) {
      for (int boxCol = 0; boxCol < 3; boxCol++) {
        Set<int> boxNumbers = {};
        for (int i = 0; i < 3; i++) {
          for (int j = 0; j < 3; j++) {
            final row = boxRow * 3 + i;
            final col = boxCol * 3 + j;
            if (board[row][col] != 0) {
              if (boxNumbers.contains(board[row][col])) {
                // Find all instances of this duplicate in the box and mark them invalid.
                for (int k = 0; k < 3; k++) {
                  for (int l = 0; l < 3; l++) {
                    final subgridRow = boxRow * 3 + k;
                    final subgridCol = boxCol * 3 + l;
                    if (board[subgridRow][subgridCol] == board[row][col]) {
                      invalidCells[subgridRow][subgridCol] = true;
                    }
                  }
                }
              }
              boxNumbers.add(board[row][col]);
            }
          }
        }
      }
    }
    return invalidCells;
  }

  // Generates a complete, solved Sudoku board using a backtracking algorithm.
  List<List<int>> _generateSolvedBoard() {
    final board = List.generate(9, (_) => List.filled(9, 0));
    _fillBoard(board);
    return board;
  }

  // Recursive function to fill the Sudoku board.
  bool _fillBoard(List<List<int>> board) {
    final random = Random();
    for (int row = 0; row < 9; row++) {
      for (int col = 0; col < 9; col++) {
        if (board[row][col] == 0) {
          final numbers = List.generate(9, (index) => index + 1)..shuffle(random);
          for (final number in numbers) {
            if (_isValidPlacement(board, row, col, number)) {
              board[row][col] = number;
              if (_fillBoard(board)) {
                return true;
              }
              board[row][col] = 0; // Backtrack
            }
          }
          return false; // No number works, must backtrack
        }
      }
    }
    return true; // Board is full
  }

  // Checks if a number can be placed at a given position.
  bool _isValidPlacement(List<List<int>> board, int row, int col, int number) {
    // Check row
    for (int i = 0; i < 9; i++) {
      if (board[row][i] == number) return false;
    }
    // Check column
    for (int i = 0; i < 9; i++) {
      if (board[i][col] == number) return false;
    }
    // Check 3x3 subgrid
    int startRow = (row ~/ 3) * 3;
    int startCol = (col ~/ 3) * 3;
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (board[startRow + i][startCol + j] == number) return false;
      }
    }
    return true;
  }

  // Removes a specified number of cells from the solved board to create a puzzle.
  void _removeNumbersFromBoard(List<List<int>> board, int numbersToRemove) {
    final random = Random();
    int count = 0;
    while (count < numbersToRemove) {
      int row = random.nextInt(9);
      int col = random.nextInt(9);
      if (board[row][col] != 0) {
        board[row][col] = 0;
        count++;
      }
    }
  }
}