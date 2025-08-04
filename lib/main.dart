import 'package:SudoGo/screens/sudoku_game_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/sudoku_bloc.dart';
import 'database/database.dart';

void main() {
  final database = SudokuDatabase();
  runApp(MyApp(database: database));
}

class MyApp extends StatelessWidget {
  final SudokuDatabase database;

  const MyApp({super.key, required this.database});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SudokuBloc(database: database),
      child: MaterialApp(
        title: 'Flutter Sudoku BLoC',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          scaffoldBackgroundColor: Colors.grey[100],
        ),
        // The app now starts with the SplashScreen
        home: const SudokuGameScreen(),
      ),
    );
  }
}
