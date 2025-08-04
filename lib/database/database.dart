
import 'dart:convert';
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

part 'database.g.dart';

@DataClassName('SudokuGame')
class SudokuGames extends Table {
  TextColumn get id => text().clientDefault(() => const Uuid().v4())();
  TextColumn get initialBoard => text()();
  TextColumn get currentBoard => text()();
  TextColumn get solvedBoard => text()();
  DateTimeColumn get createdAt => dateTime().clientDefault(() => DateTime.now())();

  @override
  Set<Column> get primaryKey => {id};
}

@DriftDatabase(tables: [SudokuGames])
class SudokuDatabase extends _$SudokuDatabase {
  SudokuDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<SudokuGame?> getMostRecentGame() {
    return (select(sudokuGames)
      ..orderBy([
            (t) => OrderingTerm(expression: t.createdAt, mode: OrderingMode.desc)
      ])
      ..limit(1))
        .getSingleOrNull();
  }

  Future<void> saveGame(String id, List<List<int>> currentBoard, List<List<int>> initialBoard, List<List<int>> solvedBoard) {
    return into(sudokuGames).insertOnConflictUpdate(
      SudokuGamesCompanion.insert(
        id: Value(id),
        initialBoard: jsonEncode(initialBoard),
        currentBoard: jsonEncode(currentBoard),
        solvedBoard: jsonEncode(solvedBoard),
      ),
    );
  }

  Future<void> updateGame(String id, List<List<int>> currentBoard) {
    return (update(sudokuGames)..where((t) => t.id.equals(id))).write(
      SudokuGamesCompanion(
        currentBoard: Value(jsonEncode(currentBoard)),
      ),
    );
  }

  Future<void> deleteGame(String id) {
    return (delete(sudokuGames)..where((t) => t.id.equals(id))).go();
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
