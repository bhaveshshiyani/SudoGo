// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $SudokuGamesTable extends SudokuGames
    with TableInfo<$SudokuGamesTable, SudokuGame> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SudokuGamesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: () => const Uuid().v4(),
  );
  static const VerificationMeta _initialBoardMeta = const VerificationMeta(
    'initialBoard',
  );
  @override
  late final GeneratedColumn<String> initialBoard = GeneratedColumn<String>(
    'initial_board',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _currentBoardMeta = const VerificationMeta(
    'currentBoard',
  );
  @override
  late final GeneratedColumn<String> currentBoard = GeneratedColumn<String>(
    'current_board',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _solvedBoardMeta = const VerificationMeta(
    'solvedBoard',
  );
  @override
  late final GeneratedColumn<String> solvedBoard = GeneratedColumn<String>(
    'solved_board',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: () => DateTime.now(),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    initialBoard,
    currentBoard,
    solvedBoard,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sudoku_games';
  @override
  VerificationContext validateIntegrity(
    Insertable<SudokuGame> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('initial_board')) {
      context.handle(
        _initialBoardMeta,
        initialBoard.isAcceptableOrUnknown(
          data['initial_board']!,
          _initialBoardMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_initialBoardMeta);
    }
    if (data.containsKey('current_board')) {
      context.handle(
        _currentBoardMeta,
        currentBoard.isAcceptableOrUnknown(
          data['current_board']!,
          _currentBoardMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_currentBoardMeta);
    }
    if (data.containsKey('solved_board')) {
      context.handle(
        _solvedBoardMeta,
        solvedBoard.isAcceptableOrUnknown(
          data['solved_board']!,
          _solvedBoardMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_solvedBoardMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SudokuGame map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SudokuGame(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      initialBoard: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}initial_board'],
      )!,
      currentBoard: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}current_board'],
      )!,
      solvedBoard: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}solved_board'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $SudokuGamesTable createAlias(String alias) {
    return $SudokuGamesTable(attachedDatabase, alias);
  }
}

class SudokuGame extends DataClass implements Insertable<SudokuGame> {
  final String id;
  final String initialBoard;
  final String currentBoard;
  final String solvedBoard;
  final DateTime createdAt;
  const SudokuGame({
    required this.id,
    required this.initialBoard,
    required this.currentBoard,
    required this.solvedBoard,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['initial_board'] = Variable<String>(initialBoard);
    map['current_board'] = Variable<String>(currentBoard);
    map['solved_board'] = Variable<String>(solvedBoard);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  SudokuGamesCompanion toCompanion(bool nullToAbsent) {
    return SudokuGamesCompanion(
      id: Value(id),
      initialBoard: Value(initialBoard),
      currentBoard: Value(currentBoard),
      solvedBoard: Value(solvedBoard),
      createdAt: Value(createdAt),
    );
  }

  factory SudokuGame.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SudokuGame(
      id: serializer.fromJson<String>(json['id']),
      initialBoard: serializer.fromJson<String>(json['initialBoard']),
      currentBoard: serializer.fromJson<String>(json['currentBoard']),
      solvedBoard: serializer.fromJson<String>(json['solvedBoard']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'initialBoard': serializer.toJson<String>(initialBoard),
      'currentBoard': serializer.toJson<String>(currentBoard),
      'solvedBoard': serializer.toJson<String>(solvedBoard),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  SudokuGame copyWith({
    String? id,
    String? initialBoard,
    String? currentBoard,
    String? solvedBoard,
    DateTime? createdAt,
  }) => SudokuGame(
    id: id ?? this.id,
    initialBoard: initialBoard ?? this.initialBoard,
    currentBoard: currentBoard ?? this.currentBoard,
    solvedBoard: solvedBoard ?? this.solvedBoard,
    createdAt: createdAt ?? this.createdAt,
  );
  SudokuGame copyWithCompanion(SudokuGamesCompanion data) {
    return SudokuGame(
      id: data.id.present ? data.id.value : this.id,
      initialBoard: data.initialBoard.present
          ? data.initialBoard.value
          : this.initialBoard,
      currentBoard: data.currentBoard.present
          ? data.currentBoard.value
          : this.currentBoard,
      solvedBoard: data.solvedBoard.present
          ? data.solvedBoard.value
          : this.solvedBoard,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SudokuGame(')
          ..write('id: $id, ')
          ..write('initialBoard: $initialBoard, ')
          ..write('currentBoard: $currentBoard, ')
          ..write('solvedBoard: $solvedBoard, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, initialBoard, currentBoard, solvedBoard, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SudokuGame &&
          other.id == this.id &&
          other.initialBoard == this.initialBoard &&
          other.currentBoard == this.currentBoard &&
          other.solvedBoard == this.solvedBoard &&
          other.createdAt == this.createdAt);
}

class SudokuGamesCompanion extends UpdateCompanion<SudokuGame> {
  final Value<String> id;
  final Value<String> initialBoard;
  final Value<String> currentBoard;
  final Value<String> solvedBoard;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const SudokuGamesCompanion({
    this.id = const Value.absent(),
    this.initialBoard = const Value.absent(),
    this.currentBoard = const Value.absent(),
    this.solvedBoard = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SudokuGamesCompanion.insert({
    this.id = const Value.absent(),
    required String initialBoard,
    required String currentBoard,
    required String solvedBoard,
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : initialBoard = Value(initialBoard),
       currentBoard = Value(currentBoard),
       solvedBoard = Value(solvedBoard);
  static Insertable<SudokuGame> custom({
    Expression<String>? id,
    Expression<String>? initialBoard,
    Expression<String>? currentBoard,
    Expression<String>? solvedBoard,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (initialBoard != null) 'initial_board': initialBoard,
      if (currentBoard != null) 'current_board': currentBoard,
      if (solvedBoard != null) 'solved_board': solvedBoard,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SudokuGamesCompanion copyWith({
    Value<String>? id,
    Value<String>? initialBoard,
    Value<String>? currentBoard,
    Value<String>? solvedBoard,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return SudokuGamesCompanion(
      id: id ?? this.id,
      initialBoard: initialBoard ?? this.initialBoard,
      currentBoard: currentBoard ?? this.currentBoard,
      solvedBoard: solvedBoard ?? this.solvedBoard,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (initialBoard.present) {
      map['initial_board'] = Variable<String>(initialBoard.value);
    }
    if (currentBoard.present) {
      map['current_board'] = Variable<String>(currentBoard.value);
    }
    if (solvedBoard.present) {
      map['solved_board'] = Variable<String>(solvedBoard.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SudokuGamesCompanion(')
          ..write('id: $id, ')
          ..write('initialBoard: $initialBoard, ')
          ..write('currentBoard: $currentBoard, ')
          ..write('solvedBoard: $solvedBoard, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$SudokuDatabase extends GeneratedDatabase {
  _$SudokuDatabase(QueryExecutor e) : super(e);
  $SudokuDatabaseManager get managers => $SudokuDatabaseManager(this);
  late final $SudokuGamesTable sudokuGames = $SudokuGamesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [sudokuGames];
}

typedef $$SudokuGamesTableCreateCompanionBuilder =
    SudokuGamesCompanion Function({
      Value<String> id,
      required String initialBoard,
      required String currentBoard,
      required String solvedBoard,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });
typedef $$SudokuGamesTableUpdateCompanionBuilder =
    SudokuGamesCompanion Function({
      Value<String> id,
      Value<String> initialBoard,
      Value<String> currentBoard,
      Value<String> solvedBoard,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

class $$SudokuGamesTableFilterComposer
    extends Composer<_$SudokuDatabase, $SudokuGamesTable> {
  $$SudokuGamesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get initialBoard => $composableBuilder(
    column: $table.initialBoard,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currentBoard => $composableBuilder(
    column: $table.currentBoard,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get solvedBoard => $composableBuilder(
    column: $table.solvedBoard,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SudokuGamesTableOrderingComposer
    extends Composer<_$SudokuDatabase, $SudokuGamesTable> {
  $$SudokuGamesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get initialBoard => $composableBuilder(
    column: $table.initialBoard,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currentBoard => $composableBuilder(
    column: $table.currentBoard,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get solvedBoard => $composableBuilder(
    column: $table.solvedBoard,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SudokuGamesTableAnnotationComposer
    extends Composer<_$SudokuDatabase, $SudokuGamesTable> {
  $$SudokuGamesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get initialBoard => $composableBuilder(
    column: $table.initialBoard,
    builder: (column) => column,
  );

  GeneratedColumn<String> get currentBoard => $composableBuilder(
    column: $table.currentBoard,
    builder: (column) => column,
  );

  GeneratedColumn<String> get solvedBoard => $composableBuilder(
    column: $table.solvedBoard,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$SudokuGamesTableTableManager
    extends
        RootTableManager<
          _$SudokuDatabase,
          $SudokuGamesTable,
          SudokuGame,
          $$SudokuGamesTableFilterComposer,
          $$SudokuGamesTableOrderingComposer,
          $$SudokuGamesTableAnnotationComposer,
          $$SudokuGamesTableCreateCompanionBuilder,
          $$SudokuGamesTableUpdateCompanionBuilder,
          (
            SudokuGame,
            BaseReferences<_$SudokuDatabase, $SudokuGamesTable, SudokuGame>,
          ),
          SudokuGame,
          PrefetchHooks Function()
        > {
  $$SudokuGamesTableTableManager(_$SudokuDatabase db, $SudokuGamesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SudokuGamesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SudokuGamesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SudokuGamesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> initialBoard = const Value.absent(),
                Value<String> currentBoard = const Value.absent(),
                Value<String> solvedBoard = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SudokuGamesCompanion(
                id: id,
                initialBoard: initialBoard,
                currentBoard: currentBoard,
                solvedBoard: solvedBoard,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                required String initialBoard,
                required String currentBoard,
                required String solvedBoard,
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SudokuGamesCompanion.insert(
                id: id,
                initialBoard: initialBoard,
                currentBoard: currentBoard,
                solvedBoard: solvedBoard,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SudokuGamesTableProcessedTableManager =
    ProcessedTableManager<
      _$SudokuDatabase,
      $SudokuGamesTable,
      SudokuGame,
      $$SudokuGamesTableFilterComposer,
      $$SudokuGamesTableOrderingComposer,
      $$SudokuGamesTableAnnotationComposer,
      $$SudokuGamesTableCreateCompanionBuilder,
      $$SudokuGamesTableUpdateCompanionBuilder,
      (
        SudokuGame,
        BaseReferences<_$SudokuDatabase, $SudokuGamesTable, SudokuGame>,
      ),
      SudokuGame,
      PrefetchHooks Function()
    >;

class $SudokuDatabaseManager {
  final _$SudokuDatabase _db;
  $SudokuDatabaseManager(this._db);
  $$SudokuGamesTableTableManager get sudokuGames =>
      $$SudokuGamesTableTableManager(_db, _db.sudokuGames);
}
