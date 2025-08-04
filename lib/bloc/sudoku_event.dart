import 'package:equatable/equatable.dart';

abstract class SudokuEvent extends Equatable {
  const SudokuEvent();

  @override
  List<Object> get props => [];
}

class NewGameEvent extends SudokuEvent {}
class ResetGameEvent extends SudokuEvent {}
class CellTappedEvent extends SudokuEvent {
  final int row;
  final int col;

  const CellTappedEvent({required this.row, required this.col});

  @override
  List<Object> get props => [row, col];
}

class NumberSelectedEvent extends SudokuEvent {
  final int number;

  const NumberSelectedEvent({required this.number});

  @override
  List<Object> get props => [number];
}

class ClearCellEvent extends SudokuEvent {}

class LoadGameEvent extends SudokuEvent {
  const LoadGameEvent();
}