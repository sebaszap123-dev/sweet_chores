part of 'todo_bloc.dart';

abstract class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object?> get props => [];
}

class TodoStarted extends TodoEvent {}

class AddTodo extends TodoEvent {
  final Todo todo;
  const AddTodo(this.todo);

  @override
  List<Object> get props => [todo];
}

class AddCategoriesIds extends TodoEvent {
  final List<int> ids;
  const AddCategoriesIds({required this.ids});

  @override
  List<Object> get props => [ids];
}

class SaveRawDate extends TodoEvent {
  final bool hasTime;
  const SaveRawDate(this.hasTime);

  @override
  List<Object> get props => [hasTime];
}

class RemoveTodo extends TodoEvent {
  final Todo todo;
  const RemoveTodo(this.todo);

  @override
  List<Object> get props => [todo];
}

class AlterTodo extends TodoEvent {
  final int index;
  const AlterTodo(this.index);

  @override
  List<Object> get props => [index];
}

class EditTodo extends TodoEvent {
  final Todo todo;
  const EditTodo(this.todo);

  @override
  List<Object> get props => [todo];
}

class FilterTodosByCategories extends TodoEvent {
  final Categories category;
  final bool categoryAdd;
  const FilterTodosByCategories(this.category, this.categoryAdd);

  @override
  List<Object> get props => [category, categoryAdd];
}

class FilterTodos extends TodoEvent {
  final FilterStatus filterStatus;
  const FilterTodos({required this.filterStatus});
  @override
  List<Object> get props => [filterStatus];
}

class RestoreTodos extends TodoEvent {
  final List<Todo> todos;
  const RestoreTodos({required this.todos});
  @override
  List<Object> get props => [todos];
}
