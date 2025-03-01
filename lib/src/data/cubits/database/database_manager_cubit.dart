import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sweet_chores/src/config/local/database_notes.dart';
import 'package:sweet_chores/src/config/local/sweet_secure_preferences.dart';
import 'package:sweet_chores/src/config/themes/theme_colors.dart';
import 'package:sweet_chores/src/core/utils/sweet_chores_dialogs.dart';
import 'package:sweet_chores/src/data/data_source.dart';
import 'package:sweet_chores/src/data/servicelocator.dart';
import 'package:sweet_chores/src/models/models.dart';
import 'dart:convert' as convert;

part 'database_manager_state.dart';

/// Main Manager Database need to be in first instance when creating the app (BlocProvider or MultiBloc)
class DatabaseManagerCubit extends Cubit<DatabaseManagerState> {
  final Database db;
  DatabaseManagerCubit(this.db) : super(DatabaseManagerState(db: db));

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

  static Future<void> _autoDeleteTask(Database db) async {
    final isActive = await SweetSecurePreferences.isActiveAutoDelete;
    final timeLapse = await SweetSecurePreferences.nextDeleteDate;
    final now = DateTime.now().millisecondsSinceEpoch;
    if (isActive &&
        timeLapse != null &&
        timeLapse.millisecondsSinceEpoch <= now) {
      await db
          .delete(DatabaseNotes.tbNotes, where: 'isDone = ?', whereArgs: [1]);
    }
  }

  static Future<DatabaseManagerCubit> startManager() async {
    final db = await _initDatabase();
    return DatabaseManagerCubit(db);
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
          name: DatabaseNotes.defaultCategory,
          color: sweetIconColors[0],
          iconData: Icons.category_sharp,
        ).toJson(),
      );
    } catch (e) {
      throw Exception('SQL error');
    }
  }

  static Future<void> _databaseVersion2(Database db) async {}

  Future<void> onLogOut() async {
    final dbs = db;

    final batch = dbs.batch();

    batch.delete(DatabaseNotes.tbNotes);
    batch.delete(DatabaseNotes.tbCategories);
    await batch.commit();
  }

  Future<void> toDefaults() async {
    await db.delete(DatabaseNotes.tbNotes);
    await db.delete(DatabaseNotes.tbCategories);
    final category = Categories(
      name: DatabaseNotes.defaultCategory,
      color: sweetIconColors[0],
      iconData: Icons.category_sharp,
    );
    await db.insert(
      DatabaseNotes.tbCategories,
      category.toJson(),
    );
  }

  Future<bool> restoreBackup(String backup) async {
    try {
      final dbs = db;
      final batch = dbs.batch();
      backup;
      List<Todo> todos = [];
      List<Categories> categories = [];
      // Decodificar el backup JSON
      final Map<String, dynamic> backupData = convert.jsonDecode(backup);
      backupData.forEach((key, value) {
        // Comprueba si la clave es igual a la clave de notas de la base de datos
        if (key == DatabaseNotes.tbNotes) {
          // Si es así, convierte el valor JSON a un objeto Todo
          for (var todo in value) {
            todos.add(Todo.fromRawJson(todo));
          }
        } else {
          for (var ca in value) {
            categories.add(Categories.fromRawJson(ca));
          }
        }
      });
      // Eliminar todos los registros existentes
      batch.delete(DatabaseNotes.tbCategories);
      batch.delete(DatabaseNotes.tbNotes);

      await batch.commit();
      // Insertar los nuevos registros
      if (todos.isNotEmpty) {
        for (var todo in todos) {
          batch.insert(DatabaseNotes.tbNotes, todo.toJson());
        }
      }
      if (categories.isNotEmpty) {
        for (var ca in categories) {
          batch.insert(DatabaseNotes.tbCategories, ca.toJson());
        }
      }
      await batch.commit(continueOnError: false, noResult: true);
      getIt<SweetChoresNotesBloc>().add(RestoreChoresEvent(todos, categories));
      return true;
    } catch (e) {
      SweetDialogs.databaseSqlite(error: '$e');
      return false;
    }
  }
}
