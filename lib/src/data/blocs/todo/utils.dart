import 'package:sweet_chores/src/models/models.dart';

List<Todo> filterDones(List<Todo> todoList) {
  final List<Todo> doneTodos = [];
  todoList.removeWhere((todo) {
    if (todo.isDone) {
      doneTodos.add(todo);
      return true;
    }
    return false;
  });
  return doneTodos;
}
