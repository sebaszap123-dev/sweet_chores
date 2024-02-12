import 'package:sweet_chores/src/config/local/database_notes.dart';
import 'package:sweet_chores/src/data/cubits/cubits.dart';
import 'package:sweet_chores/src/models/todo.dart';
import 'package:sweet_chores/src/data/servicelocator.dart';

import '../repository/repository.dart';

class TodoHelper implements TodoRepository {
  DatabaseManagerCubit dbManager = getIt<DatabaseManagerCubit>();

  /// open the state.db or create it and the table $tbName
  @override
  Future<int> addTodo(
    Todo todo,
  ) async {
    // Verificar db
    final resp = await dbManager.state.db
        .insert(DatabaseNotes.tbNotes, todo.toJsonSql());
    return resp;
  }

  @override
  Future<Todo?> getTodoById(int id) async {
    final resp = await dbManager.state.db
        .query(DatabaseNotes.tbNotes, where: 'id = ?', whereArgs: [id]);
    return resp.isNotEmpty ? Todo.fromJson(resp.first) : null;
  }

  @override
  Future<List<Todo>> getAllTodos() async {
    final resp = await dbManager.state.db.query(DatabaseNotes.tbNotes);

    List<Todo> todos = resp.isNotEmpty
        ? resp.map((todo) => Todo.fromJson(todo)).toList()
        : <Todo>[];

    todos.sort((a, b) {
      return (a.dueDate ?? 0).compareTo(b.dueDate ?? 0);
    });

    return todos;
  }

  @override
  Future<int> updateTodo(
    Todo todo,
  ) async {
    final resp = await dbManager.state.db.update(
        DatabaseNotes.tbNotes, todo.toJson(),
        where: 'id = ?', whereArgs: [todo.id]);
    return resp;
  }

  @override
  Future<int> deleteAllTodos() async {
    final resp = await dbManager.state.db.delete(DatabaseNotes.tbNotes);
    return resp;
  }

  @override
  Future<int> deleteTodoById(int id) async {
    final resp = await dbManager.state.db
        .delete(DatabaseNotes.tbNotes, where: 'id = ?', whereArgs: [id]);
    return resp;
  }

  @override
  Future<bool> deleteDonesTodos() async {
    try {
      final resp = await dbManager.state.db
          .delete(DatabaseNotes.tbNotes, where: 'isDone = ?', whereArgs: [1]);
      return resp != 0;
    } catch (e) {
      print('$e');
      return false;
    }
  }
}
