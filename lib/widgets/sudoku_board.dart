import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/sudoku_bloc.dart';
import '../bloc/sudoku_event.dart';

class SudokuBoard extends StatelessWidget {
  final List<List<int>> board;
  final List<List<int>> initialBoard;
  final int selectedRow;
  final int selectedCol;
  final List<List<bool>> invalidCells;

  const SudokuBoard({
    super.key,
    required this.board,
    required this.initialBoard,
    required this.selectedRow,
    required this.selectedCol,
    required this.invalidCells,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Column(
          children: List.generate(9, (row) {
            return Expanded(
              child: Row(
                children: List.generate(9, (col) {
                  return Expanded(
                    child: SudokuCell(
                      value: board[row][col],
                      isInitial: initialBoard[row][col] != 0,
                      isSelected: row == selectedRow && col == selectedCol,
                      isInvalid: invalidCells[row][col],
                      onTap: () {
                        context.read<SudokuBloc>().add(CellTappedEvent(row: row, col: col));
                      },
                      isSubgridBorder: (row + 1) % 3 == 0 && row != 8,
                      isColumnBorder: (col + 1) % 3 == 0 && col != 8,
                    ),
                  );
                }),
              ),
            );
          }),
        ),
      ),
    );
  }
}

class SudokuCell extends StatelessWidget {
  final int value;
  final bool isInitial;
  final bool isSelected;
  final bool isInvalid;
  final VoidCallback onTap;
  final bool isSubgridBorder;
  final bool isColumnBorder;

  const SudokuCell({
    super.key,
    required this.value,
    required this.isInitial,
    required this.isSelected,
    required this.isInvalid,
    required this.onTap,
    required this.isSubgridBorder,
    required this.isColumnBorder,
  });

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = isSelected
        ? Colors.lightBlue[100]!
        : isInvalid
        ? Colors.red[100]!
        : Colors.white;

    Color textColor = isInvalid
        ? Colors.red
        : isInitial
        ? Colors.black
        : Colors.blue;

    final double borderWidth = 0.5;
    final Color borderColor = Colors.grey.shade400;
    final double subgridBorderWidth = 2.0;
    final Color subgridBorderColor = Colors.black;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border(
            right: BorderSide(
              color: isColumnBorder ? subgridBorderColor : borderColor,
              width: isColumnBorder ? subgridBorderWidth : borderWidth,
            ),
            bottom: BorderSide(
              color: isSubgridBorder ? subgridBorderColor : borderColor,
              width: isSubgridBorder ? subgridBorderWidth : borderWidth,
            ),
            left: BorderSide(
              color: borderColor,
              width: borderWidth,
            ),
            top: BorderSide(
              color: borderColor,
              width: borderWidth,
            ),
          ),
        ),
        child: Center(
          child: Text(
            value == 0 ? '' : value.toString(),
            style: TextStyle(
              fontSize: 24,
              fontWeight: isInitial ? FontWeight.bold : FontWeight.normal,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }
}
