import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/sudoku_bloc.dart';
import '../bloc/sudoku_event.dart';
import '../bloc/sudoku_state.dart';
import '../widgets/number_pad.dart';
import '../widgets/sudoku_board.dart';

class SudokuGameScreen extends StatefulWidget {
  const SudokuGameScreen({super.key});

  @override
  State<SudokuGameScreen> createState() => _SudokuGameScreenState();
}

class _SudokuGameScreenState extends State<SudokuGameScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _iconAnimation;
  late Animation<Offset> _textAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _iconAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.fastOutSlowIn,
      ),
    );

    _textAnimation = Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero)
        .animate(
          CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
        );

    _animationController.forward();
    context.read<SudokuBloc>().add(const LoadGameEvent());
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  /*@override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blueAccent, Colors.purpleAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: BlocConsumer<SudokuBloc, SudokuState>(
          listener: (context, state) {
            if (state is SudokuLoaded && state.isSolved) {
              _showWinDialog(context);
            }
          },
          builder: (context, state) {
            if (state is SudokuLoaded) {
              return Column(
                children: [
                  AppBar(
                    title: const Text(
                      'SudoGo',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    centerTitle: true,
                  ),
                  Expanded(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            final size =
                            constraints.maxHeight < constraints.maxWidth
                                ? constraints.maxHeight
                                : constraints.maxWidth;
                            return SizedBox(
                              width: size,
                              height: size,
                              child: SudokuBoard(
                                board: state.board,
                                initialBoard: state.initialBoard,
                                selectedRow: state.selectedRow,
                                selectedCol: state.selectedCol,
                                invalidCells: state.invalidCells,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 20.0,
                      horizontal: 16.0,
                    ),
                    child: NumberPad(
                      onNumberSelected: (number) {
                        context.read<SudokuBloc>().add(
                          NumberSelectedEvent(number: number),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 20.0,
                      horizontal: 16.0,
                    ),
                    child: OrientationBuilder(
                      builder: (context, orientation) {
                        return Wrap(
                          spacing: 12.0,
                          runSpacing: 12.0,
                          alignment: WrapAlignment.center,
                          children: [
                            ElevatedButton.icon(
                              onPressed: () {
                                // Check if a cell is selected, is not a pre-filled cell, and contains a number to clear.
                                if (state.selectedRow != -1 &&
                                    state.selectedCol != -1 &&
                                    state.initialBoard[state.selectedRow][state
                                        .selectedCol] ==
                                        0 &&
                                    state.board[state.selectedRow][state
                                        .selectedCol] !=
                                        0) {
                                  context.read<SudokuBloc>().add(
                                    ClearCellEvent(),
                                  );
                                }
                              },
                              icon: const Icon(Icons.clear),
                              label: const Text('Clear'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red[400],
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                elevation: 5,
                              ),
                            ),
                            ElevatedButton.icon(
                              onPressed: () {
                                _showResetConfirmationDialog(context, () {
                                  context.read<SudokuBloc>().add(
                                    ResetGameEvent(),
                                  );
                                });
                              },
                              icon: const Icon(Icons.refresh),
                              label: const Text('Reset'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.amber[600],
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                elevation: 5,
                              ),
                            ),
                            ElevatedButton.icon(
                              onPressed: () {
                                _showNewGameConfirmationDialog(context, () {
                                  context.read<SudokuBloc>().add(
                                    NewGameEvent(),
                                  );
                                });
                              },
                              icon: const Icon(Icons.play_arrow),
                              label: const Text('New Game'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green[600],
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                elevation: 5,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              );
            }
            return Center(
              child: AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ScaleTransition(
                        scale: _iconAnimation,
                        child: const Icon(
                          Icons.grid_on,
                          size: 100,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 16),
                      SlideTransition(
                        position: _textAnimation,
                        child: RichText(
                          text: TextSpan(
                            style: const TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              shadows: [
                                Shadow(
                                  offset: Offset(2, 2),
                                  blurRadius: 3.0,
                                  color: Color.fromARGB(100, 0, 0, 0),
                                ),
                              ],
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: 'SUDOKU',
                                style: TextStyle(color: Colors.yellow[300]),
                              ),
                              const TextSpan(text: ' GAME'),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      SlideTransition(
                        position: _textAnimation,
                        child: Text(
                          'A logic puzzle game',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ],
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blueAccent, Colors.purpleAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: BlocConsumer<SudokuBloc, SudokuState>(
          listener: (context, state) {
            if (state is SudokuLoaded && state.isSolved) {
              _showWinDialog(context);
            }
          },
          builder: (context, state) {
            if (state is SudokuLoaded) {
              return OrientationBuilder(
                builder: (context, orientation) {
                  return Column(
                    children: [
                      if (orientation == Orientation.portrait) ...[
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 36.0,
                            horizontal: 16.0,
                          ),
                          child: Text(
                            'SudoGo',
                            style: TextStyle(
                              fontSize: orientation == Orientation.portrait
                                  ? 48
                                  : 36,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              shadows: [
                                Shadow(
                                  offset: const Offset(2, 2),
                                  blurRadius: 3.0,
                                  color: Colors.black.withOpacity(0.4),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: SudokuBoard(
                                board: state.board,
                                initialBoard: state.initialBoard,
                                selectedRow: state.selectedRow,
                                selectedCol: state.selectedCol,
                                invalidCells: state.invalidCells,
                              ),
                            ),
                          ),
                        ),
                        NumberPad(
                          onNumberSelected: (number) {
                            context.read<SudokuBloc>().add(
                              NumberSelectedEvent(number: number),
                            );
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 20.0,
                            horizontal: 16.0,
                          ),
                          child: Wrap(
                            spacing: 12.0,
                            runSpacing: 12.0,
                            alignment: WrapAlignment.center,
                            children: [
                              ElevatedButton.icon(
                                onPressed: () {
                                  // Check if a cell is selected, is not a pre-filled cell, and contains a number to clear.
                                  if (state.selectedRow != -1 &&
                                      state.selectedCol != -1 &&
                                      state.initialBoard[state
                                              .selectedRow][state
                                              .selectedCol] ==
                                          0 &&
                                      state.board[state.selectedRow][state
                                              .selectedCol] !=
                                          0) {
                                    context.read<SudokuBloc>().add(
                                      ClearCellEvent(),
                                    );
                                  }
                                },
                                icon: const Icon(Icons.clear),
                                label: const Text('Clear'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red[400],
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  elevation: 5,
                                ),
                              ),
                              ElevatedButton.icon(
                                onPressed: () {
                                  _showResetConfirmationDialog(context, () {
                                    context.read<SudokuBloc>().add(
                                      ResetGameEvent(),
                                    );
                                  });
                                },
                                icon: const Icon(Icons.refresh),
                                label: const Text('Reset'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.amber[600],
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  elevation: 5,
                                ),
                              ),
                              ElevatedButton.icon(
                                onPressed: () {
                                  _showNewGameConfirmationDialog(context, () {
                                    context.read<SudokuBloc>().add(
                                      NewGameEvent(),
                                    );
                                  });
                                },
                                icon: const Icon(Icons.play_arrow),
                                label: const Text('New Game'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green[600],
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  elevation: 5,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ] else ...[
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 20, bottom: 30),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: LayoutBuilder(
                                        builder: (context, constraints) {
                                          final size =
                                              constraints.maxHeight <
                                                  constraints.maxWidth
                                              ? constraints.maxHeight
                                              : constraints.maxWidth;
                                          return SizedBox(
                                            width: size,
                                            height: size,
                                            child: SudokuBoard(
                                              board: state.board,
                                              initialBoard: state.initialBoard,
                                              selectedRow: state.selectedRow,
                                              selectedCol: state.selectedCol,
                                              invalidCells: state.invalidCells,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 15.0,
                                          horizontal: 16.0,
                                        ),
                                        child: Text(
                                          'SudoGo',
                                          style: TextStyle(
                                            fontSize: 48,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            shadows: [
                                              Shadow(
                                                offset: const Offset(2, 2),
                                                blurRadius: 3.0,
                                                color: Colors.black.withOpacity(
                                                  0.4,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      NumberPad(
                                        onNumberSelected: (number) {
                                          context.read<SudokuBloc>().add(
                                            NumberSelectedEvent(number: number),
                                          );
                                        },
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 20.0,
                                          horizontal: 16.0,
                                        ),
                                        child: Wrap(
                                          spacing: 12.0,
                                          runSpacing: 12.0,
                                          alignment: WrapAlignment.center,
                                          children: [
                                            ElevatedButton.icon(
                                              onPressed: () {
                                                if (state.selectedRow != -1 &&
                                                    state.selectedCol != -1 &&
                                                    state.initialBoard[state
                                                            .selectedRow][state
                                                            .selectedCol] ==
                                                        0 &&
                                                    state.board[state
                                                            .selectedRow][state
                                                            .selectedCol] !=
                                                        0) {
                                                  context
                                                      .read<SudokuBloc>()
                                                      .add(ClearCellEvent());
                                                }
                                              },
                                              icon: const Icon(Icons.clear),
                                              label: const Text('Clear'),
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    Colors.red[400],
                                                foregroundColor: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                                elevation: 5,
                                              ),
                                            ),
                                            ElevatedButton.icon(
                                              onPressed: () {
                                                _showResetConfirmationDialog(
                                                  context,
                                                  () {
                                                    context
                                                        .read<SudokuBloc>()
                                                        .add(ResetGameEvent());
                                                  },
                                                );
                                              },
                                              icon: const Icon(Icons.refresh),
                                              label: const Text('Reset'),
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    Colors.amber[600],
                                                foregroundColor: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                                elevation: 5,
                                              ),
                                            ),
                                            ElevatedButton.icon(
                                              onPressed: () {
                                                _showNewGameConfirmationDialog(
                                                  context,
                                                  () {
                                                    context
                                                        .read<SudokuBloc>()
                                                        .add(NewGameEvent());
                                                  },
                                                );
                                              },
                                              icon: const Icon(
                                                Icons.play_arrow,
                                              ),
                                              label: const Text('New Game'),
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    Colors.green[600],
                                                foregroundColor: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                                elevation: 5,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ],
                  );
                },
              );
            }
            return Center(
              child: AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ScaleTransition(
                        scale: _iconAnimation,
                        child: const Icon(
                          Icons.grid_on,
                          size: 100,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 16),
                      SlideTransition(
                        position: _textAnimation,
                        child: RichText(
                          text: TextSpan(
                            style: const TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              shadows: [
                                Shadow(
                                  offset: Offset(2, 2),
                                  blurRadius: 3.0,
                                  color: Color.fromARGB(100, 0, 0, 0),
                                ),
                              ],
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: 'SudoGo',
                                style: TextStyle(color: Colors.yellow[300]),
                              ),
                              //const TextSpan(text: ' GAME'),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      SlideTransition(
                        position: _textAnimation,
                        child: Text(
                          'A logic puzzle game',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ],
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }

  void _showWinDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text('Congratulations!'),
          content: const Text('You have solved the Sudoku puzzle.'),
          actions: <Widget>[
            TextButton(
              child: const Text('New Game'),
              onPressed: () {
                Navigator.of(dialogContext).pop();
                context.read<SudokuBloc>().add(NewGameEvent());
              },
            ),
          ],
        );
      },
    );
  }

  void _showResetConfirmationDialog(
    BuildContext context,
    VoidCallback onConfirm,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          backgroundColor: Colors.white.withOpacity(0.9),
          title: const Text(
            'Confirm Reset',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent,
            ),
          ),
          content: const Text(
            'Are you sure you want to reset the game? All your progress will be lost.',
            style: TextStyle(fontSize: 16, color: Colors.black87),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.blueGrey),
              ),
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
            ),
            ElevatedButton(
              child: const Text('Reset Game'),
              onPressed: () {
                Navigator.of(dialogContext).pop();
                onConfirm();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber[600],
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showNewGameConfirmationDialog(
    BuildContext context,
    VoidCallback onConfirm,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          backgroundColor: Colors.white.withOpacity(0.9),
          title: const Text(
            'Confirm New Game',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent,
            ),
          ),
          content: const Text(
            'Are you sure you want to start a new game? All unsaved progress will be lost.',
            style: TextStyle(fontSize: 16, color: Colors.black87),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.blueGrey),
              ),
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
            ),
            ElevatedButton(
              child: const Text('New Game'),
              onPressed: () {
                Navigator.of(dialogContext).pop();
                onConfirm();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[600],
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
