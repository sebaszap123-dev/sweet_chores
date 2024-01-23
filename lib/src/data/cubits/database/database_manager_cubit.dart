import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sweet_chores_reloaded/src/config/local/database_notes.dart';
import 'package:sweet_chores_reloaded/src/config/local/secure_storage.dart';
import 'package:sweet_chores_reloaded/src/config/themes/theme_colors.dart';
import 'package:sweet_chores_reloaded/src/data/blocs/blocs.dart';
import 'package:sweet_chores_reloaded/src/data/servicelocator.dart';
import 'package:sweet_chores_reloaded/src/models/models.dart';

part 'database_manager_state.dart';

/// Main Manager Database need to be in first instance when creating the app (BlocProvider or MultiBloc)
class DatabaseManagerCubit extends Cubit<DatabaseManagerState> {
  DatabaseManagerCubit()
      : super(const DatabaseManagerState(
          db: null, // Inicialmente, db es nulo
        )) {
    startManager();
  }

  static Future<Database> _initDatabase() async {
    // Inicializar la base de datos aquí y devolver la instancia de Database
    Database database = await _notesInitialization();
    await _autoDeleteTask(database);
    return database;
  }

  static Future<Database> _notesInitialization() async {
    final path = await DatabaseNotes.getPath();
    final database = await openDatabase(
      path,
      version: DatabaseNotes.version,
      onUpgrade: _onUpgrade,
      onCreate: _onCreate,
    );
    return database;
  }

  // TODO: CREATE OR ADD TO REPOSITORY AND IMPLEMENT THERE NOT HERE!!!!
  static Future<void> _autoDeleteTask(Database db) async {
    final isActive = getIt<SweetPreferencesBloc>().state.autoDeleteTask;
    final timeLapse = await getIt<SweetChoresPreferences>().getTimeTask;
    final now = DateTime.now().millisecondsSinceEpoch;
    if (isActive &&
        timeLapse != null &&
        timeLapse.millisecondsSinceEpoch <= now) {
      await db
          .delete(DatabaseNotes.tbNotes, where: 'isDone = ?', whereArgs: [1]);
    }
  }

  void startManager() async {
    final db = await _initDatabase();
    emit(state.copyWith(status: DatabaseStatus.loading));
    try {
      emit(state.copyWith(db: db, status: DatabaseStatus.ready));
    } catch (e) {
      emit(state.copyWith(status: DatabaseStatus.error));
      throw Exception("Error emiting state of status");
    }
  }

  Database get database {
    final db = state.status == DatabaseStatus.ready ? state.db : state.db;
    if (db != null) {
      return db;
    } else {
      throw Exception("Can handle database");
    }
  }

  static Future<void> _onCreate(Database db, int version) async =>
      _databaseVersion1(db);

  static Future<void> _onUpgrade(
      Database db, int oldVersion, int newVersion) async {
    for (int version = oldVersion; version < newVersion; version++) {
      await _performDbOperationsVersionWise(db, version + 1);
    }
  }

  static Future<void> _performDbOperationsVersionWise(
      Database db, int version) async {
    switch (version) {
      case 1:
        await _databaseVersion1(db);
        break;
      case 2:
        await _databaseVersion2(db);
        break;
      // case 3:
      //   await _databaseVersion3(db);
      //   break;
      // case 4:
      //   await _databaseVersion4(db);
      //   break;
      // case 5:
      //   await _databaseVersion5(db);
      //   break;
    }
  }

  static Future<void> _databaseVersion1(Database db) async {
    try {
      await db.execute(DatabaseNotes.sqlCreateTBTodoNotes);
      await db.execute(DatabaseNotes.sqlCreateTBCategories);
      await db.execute(DatabaseNotes.sqlCreateSubtask);
      await db.insert(
        DatabaseNotes.tbCategories,
        Categories(
          name: 'to-do',
          color: SweetBoyThemeColors.primary,
          iconData: Icons.category_sharp,
        ).toJson(),
      );
    } catch (e) {
      throw Exception('SQL error');
    }
  }

  static Future<void> _databaseVersion2(Database db) async {}
}
