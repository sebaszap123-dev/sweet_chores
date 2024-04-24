part of 'sweet_chores_notes_bloc.dart';

enum NotesStatus { initial, loading, success, error }

enum TodoStatus { initial, loading, creating, success, error }

enum CategoryStatus { initial, loading, creating, success, error }

enum FilterTime { all, today, week, month, overDue, done }

enum DateStatus { date, time }

class SweetChoresNotesState extends Equatable {
  final List<Todo> todos;
  final NotesStatus status;
  final TodoStatus todoStatus;
  final CategoryStatus categoryStatus;
  final FilterTime filterStatus;
  final List<Categories> categories;
  final DateStatus dateStatus;

  /// For make local db Querys
  final TodoService todoServices = TodoService(TodoHelper());

  /// For control categories
  final CategoriesService categoryService = CategoriesService();

  SweetChoresNotesState({
    this.status = NotesStatus.initial,
    this.todos = const <Todo>[],
    this.dateStatus = DateStatus.date,
    this.todoStatus = TodoStatus.initial,
    this.categoryStatus = CategoryStatus.initial,
    this.filterStatus = FilterTime.all,
    this.categories = const <Categories>[],
  });

  SweetChoresNotesState copyWith({
    List<Todo>? todos,
    NotesStatus? status,
    DateStatus? dateStatus,
    TodoStatus? todoStatus,
    CategoryStatus? categoryStatus,
    FilterTime? filterStatus,
    List<Categories>? categories,
  }) {
    return SweetChoresNotesState(
      todos: todos ?? this.todos,
      todoStatus: todoStatus ?? this.todoStatus,
      categoryStatus: categoryStatus ?? this.categoryStatus,
      filterStatus: filterStatus ?? this.filterStatus,
      categories: categories ?? this.categories,
      status: status ?? this.status,
      dateStatus: dateStatus ?? this.dateStatus,
    );
  }

  @override
  List<Object> get props => [
        todos,
        todoStatus,
        categoryStatus,
        filterStatus,
        categories,
        dateStatus,
        status
      ];
  List<Todo> get currentTodos {
    final now = DateTime.now();
    final todayStart = DateTime(now.year, now.month, now.day, 0, 0, 0);
    final todayEnd = DateTime(now.year, now.month, now.day, 23, 59, 0);
    if (activeCategories.isNotEmpty) {
      final caIds = activeCategories.map((category) => category.id).toSet();
      final filteredByCategory =
          todos.where((ca) => caIds.contains(ca.categoryID)).toList();
      switch (filterStatus) {
        case FilterTime.all:
          final undoneTodos =
              filteredByCategory.where((element) => !element.isDone);
          return [...undoneTodos];
        case FilterTime.today:
          final todayTodos = _filterAndSortByDueDate(
            todos: todos,
            start: todayStart,
            end: todayEnd,
          );
          return todayTodos;
        case FilterTime.week:
          final endOfWeek = now.endOfWeek();
          final weekTodos = _filterAndSortByDueDate(
            todos: filteredByCategory,
            start: todayStart,
            end: endOfWeek,
          );
          return weekTodos;
        case FilterTime.month:
          final endOfMonth = DateTime(
            todayEnd.year,
            todayEnd.month + 1,
            0,
            todayEnd.hour,
            todayEnd.minute,
            todayEnd.second,
          );
          final monthTodos = _filterAndSortByDueDate(
            todos: filteredByCategory,
            start: todayStart,
            end: endOfMonth,
          );
          return monthTodos;
        case FilterTime.overDue:
          final overdueTodos = filteredByCategory.where(isOverDue).toList();
          return overdueTodos;
        case FilterTime.done:
          final doneTodos =
              filteredByCategory.where((todo) => todo.isDone).toList();
          return doneTodos;
      }
    } else {
      return <Todo>[];
    }
  }

  List<Categories> get activeCategories {
    final acCategories = categories.where((ca) => ca.isActive == true).toList();
    return [...acCategories];
  }

  List<Todo> _filterAndSortByDueDate({
    required List<Todo> todos,
    DateTime? start,
    DateTime? end,
  }) {
    final filteredTodos = todos.where((todo) {
      if (todo.isDone) {
        return false;
      }
      if (start != null && todo.dueDate != null) {
        final dueDateTime = DateTime.fromMillisecondsSinceEpoch(todo.dueDate!);
        return dueDateTime.isSameDay(start) ||
            (end != null &&
                dueDateTime.isAfter(start) &&
                dueDateTime.isBefore(end));
      }
      return todo.dueDate == null;
    }).toList();

    filteredTodos.sort((a, b) {
      if (a.dueDate == null && b.dueDate == null) {
        return 0;
      } else if (a.dueDate == null) {
        return 1;
      } else if (b.dueDate == null) {
        return -1;
      } else {
        return a.dueDate!.compareTo(b.dueDate!);
      }
    });

    return filteredTodos;
  }

  Categories getCategory(int id) {
    final category = categories.firstWhere((category) => category.id == id,
        orElse: () => Categories(name: 'to-do'));
    return category;
  }
}
