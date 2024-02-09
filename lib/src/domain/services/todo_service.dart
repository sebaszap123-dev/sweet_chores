import 'package:sweet_chores/src/core/network/network_info.dart';
import 'package:sweet_chores/src/data/servicelocator.dart';
import 'package:sweet_chores/src/domain/domain.dart';
import 'package:sweet_chores/src/models/todo.dart';

class TodoService extends TodoRepository {
  final TodoHelper localHelper;
  final NetworkInfo internetInfo = getIt<NetworkInfo>();
  TodoService(this.localHelper);

  @override
  Future<int> deleteAllTodos() async {
    return await localHelper.deleteAllTodos();
  }

  @override
  Future<int> deleteTodoById(int id) async {
    return await localHelper.deleteTodoById(id);
  }

  @override
  Future<List<Todo>> getAllTodos() async {
    final network = await internetInfo.isConnected();
    if (network) {
      // Internet DB
      return [];
    } else {
      return await localHelper.getAllTodos();
    }
  }

  @override
  Future<Todo?> getTodoById(int id) async {
    return await localHelper.getTodoById(id);
  }

  @override
  Future<int> addTodo(Todo todo) async {
    return await localHelper.addTodo(todo);
  }

  @override
  Future<int> updateTodo(Todo todo) async {
    return await localHelper.updateTodo(todo);
  }
}
