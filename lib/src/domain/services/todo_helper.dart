import 'package:sweet_chores_reloaded/src/config/local/database_notes.dart';
import 'package:sweet_chores_reloaded/src/data/cubits/cubits.dart';
import 'package:sweet_chores_reloaded/src/models/todo.dart';
import 'package:sweet_chores_reloaded/src/data/servicelocator.dart';

import '../repository/repository.dart';

class TodoHelper implements TodoRepository {
  DatabaseManagerCubit dbManager = getIt<DatabaseManagerCubit>();

  /// open the database or create it and the table $tbName
  @override
  Future<int> addTodo(
    Todo todo,
  ) async {
    // Verificar db
    final resp =
        await dbManager.database.insert(DatabaseNotes.tbNotes, todo.toJson());
    return resp;
  }

  @override
  Future<Todo?> getTodoById(int id) async {
    final resp = await dbManager.database
        .query(DatabaseNotes.tbNotes, where: 'id = ?', whereArgs: [id]);
    return resp.isNotEmpty ? Todo.fromJson(resp.first) : null;
  }

  @override
  Future<List<Todo>> getAllTodos() async {
    final resp = await dbManager.database.query(DatabaseNotes.tbNotes);

    List<Todo> todos = resp.isNotEmpty
        ? resp.map((todo) => Todo.fromJson(todo)).toList()
        : <Todo>[];

    todos.sort((a, b) {
      // Ordenar por isDone
      if (a.isDone && !b.isDone) {
        return 1;
      } else if (!a.isDone && b.isDone) {
        return -1;
      }

      // Si son iguales en isDone, ordenar por dueDate
      return (a.dueDate ?? 0).compareTo(b.dueDate ?? 0);
    });

    return todos;
  }

  @override
  Future<int> updateTodo(
    Todo todo,
  ) async {
    final resp = await dbManager.database.update(
        DatabaseNotes.tbNotes, todo.toJson(),
        where: 'id = ?', whereArgs: [todo.id]);
    return resp;
  }

  @override
  Future<int> deleteAllTodos() async {
    final resp = await dbManager.database.delete(DatabaseNotes.tbNotes);
    return resp;
  }

  @override
  Future<int> deleteTodoById(int id) async {
    final resp = await dbManager.database
        .delete(DatabaseNotes.tbNotes, where: 'id = ?', whereArgs: [id]);
    return resp;
  }
}
