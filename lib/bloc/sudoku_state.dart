import 'package:equatable/equatable.dart';

abstract class SudokuState extends Equatable {
  const SudokuState();

  @override
  List<Object> get props => [];
}

class SudokuInitial extends SudokuState {}

class SudokuLoaded extends SudokuState {
  final List<List<int>> board;
  final List<List<int>> initialBoard;
  final int selectedRow;
  final int selectedCol;
  final bool isSolved;
  final List<List<bool>> invalidCells;
  final String gameId;

  const SudokuLoaded({
    required this.board,
    required this.initialBoard,
    required this.selectedRow,
    required this.selectedCol,
    required this.isSolved,
    required this.invalidCells,
    required this.gameId,
  });

  SudokuLoaded copyWith({
    List<List<int>>? board,
    int? selectedRow,
    int? selectedCol,
    bool? isSolved,
    List<List<bool>>? invalidCells,
  }) {
    return SudokuLoaded(
      board: board ?? this.board,
      initialBoard: this.initialBoard,
      selectedRow: selectedRow ?? this.selectedRow,
      selectedCol: selectedCol ?? this.selectedCol,
      isSolved: isSolved ?? this.isSolved,
      invalidCells: invalidCells ?? this.invalidCells,
      gameId: this.gameId,
    );
  }

  @override
  List<Object> get props => [board, initialBoard, selectedRow, selectedCol, isSolved, invalidCells, gameId];
}
