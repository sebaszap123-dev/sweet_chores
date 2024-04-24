import '../../models/models.dart';

abstract class TodoRepository {
  /// Create a newNote
  Future<int> addTodo(Todo todo);

  /// Get Todo by id
  Future<Todo?> getTodoById(int id);

  /// Get all Todos
  Future<List<Todo>> getAllTodos();

  /// Update a todo
  Future<int> updateTodo(Todo todo);

  /// Delete All Todo Notes
  Future<int> deleteAllTodos();

  /// Delete one by id
  Future<int> deleteTodoById(int id);

  /// Delete one by id
  Future<bool> deleteDonesTodos();
}
