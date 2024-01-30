import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

abstract class DatabaseNotes {
  /// Name of the db
  static const String _dbName = 'kawai_todo.db';

  /// Version of database change when you update the database
  static const int version = 1;

  /// Use CamelCase because is the name of the principal table
  static const String tbNotes = 'TodoNotes';
  static const String tbCategories = 'Categories';
  static const String tbSubTask = 'Subtasks';

  /// SQL Execution for create the main Table of todo notes
  static const String sqlCreateTBTodoNotes = '''
CREATE TABLE $tbNotes(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    title TEXT NOT NULL,
    isDone INTEGER NOT NULL,
    category_id INTEGER,
    description TEXT,
    dueDate INTEGER,
    hasTime INTEGER,
    FOREIGN KEY (category_id) REFERENCES $tbCategories(id)
  )''';

  /// SQL Execution for create category table
  static const String sqlCreateTBCategories =
      'CREATE TABLE $tbCategories(id integer primary key autoincrement, name TEXT NOT  NULL, color TEXT, iconData INTEGER)';

  /// SQL TABLE SUBTASKS
  /// to-do 1 -  M subtask
  static const String sqlCreateSubtask = '''
  CREATE TABLE $tbSubTask (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    note_id INTEGER NOT NULL,
    subtask_text TEXT NOT NULL,
    isDone INTEGER NOT NULL,
    FOREIGN KEY (note_id) REFERENCES $tbNotes(id)
)''';

  /// Get the path of the database for Query Tasks
  static Future<String> getPath() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, _dbName);
    return path;
  }

  static String get dbname => _dbName;
}
