part of 'todo_bloc.dart';

enum TodoStatus { initial, loading, success, error }

enum AddTodoStatus { initial, success, date, time, error }

enum FilterStatus { all, today, week, month, overDue, done }

enum FilterCategoryStatus { filtered, all }

// ignore: must_be_immutable
class TodoState extends Equatable {
  final List<Todo> todos;
  final TodoStatus status;
  final String? errorMessage;
  final FilterStatus filterStatus;
  final FilterCategoryStatus filterCategoryStatus;
  final List<int> categoryIds;
  final AddTodoStatus makeTodoStatus;
  final List<Todo> filterTodos;
  final int maxCategoryIds;

  /// For make local db Querys
  final TodoService todoServices = TodoService(TodoHelper());

  TodoState({
    this.todos = const [],
    this.filterTodos = const [],
    this.categoryIds = const [],
    this.status = TodoStatus.initial,
    this.errorMessage,
    this.filterCategoryStatus = FilterCategoryStatus.all,
    this.filterStatus = FilterStatus.all,
    this.makeTodoStatus = AddTodoStatus.initial,
    this.maxCategoryIds = 1,
  });

  TodoState copyWith({
    TodoStatus? status,
    List<Todo>? todos,
    String? errorMessage,
    FilterStatus? filterStatus,
    AddTodoStatus? makeTodoStatus,
    List<Todo>? filterTodos,
    FilterCategoryStatus? filterCS,
    List<int>? categoryIds,
  }) {
    return TodoState(
      status: status ?? this.status,
      todos: todos ?? this.todos,
      errorMessage: errorMessage ?? this.errorMessage,
      filterStatus: filterStatus ?? this.filterStatus,
      makeTodoStatus: makeTodoStatus ?? this.makeTodoStatus,
      filterTodos: filterTodos ?? this.filterTodos,
      filterCategoryStatus: filterCS ?? filterCategoryStatus,
      categoryIds: categoryIds ?? this.categoryIds,
      maxCategoryIds: categoryIds?.length ?? this.categoryIds.length,
    );
  }

  @override
  List<Object> get props =>
      [todos, status, filterStatus, makeTodoStatus, filterTodos, categoryIds];

  bool get isFiltered {
    return filterCategoryStatus == FilterCategoryStatus.filtered ||
        filterStatus != FilterStatus.all;
  }

  List<Todo> get currentTodos {
    return isFiltered ? [...filterTodos] : [...todos];
  }

  List<Todo> todosByCurrentCategories({List<int>? updatedCategoryIds}) {
    final caIds = updatedCategoryIds ?? categoryIds;
    if (caIds.isEmpty) {
      return [];
    } else {
      return todos
          .where((element) => caIds.contains(element.categoryID))
          .toList();
    }
  }
}
