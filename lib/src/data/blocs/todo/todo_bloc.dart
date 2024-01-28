import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sweet_chores_reloaded/src/core/utils/helpers.dart';
import 'package:sweet_chores_reloaded/src/core/utils/sweet_chores_dialogs.dart';
import 'package:sweet_chores_reloaded/src/domain/services/todo_service.dart';
import 'package:sweet_chores_reloaded/src/models/models.dart';
import 'package:sweet_chores_reloaded/src/domain/services/todo_helper.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(TodoState()) {
    on<TodoStarted>(_onStarted);
    on<AddTodo>(_onAddTodo);
    on<SaveRawDate>(_onSaveRawDate);
    on<RemoveTodo>(_onRemoveTodo);
    on<AlterTodo>(_onAlterTodo);
    on<FilterTodosByCategories>(_onFilterTodosByCategories);
    on<FilterTodos>(_filtersTodos);
    on<EditTodo>(_onEditTodo);
    on<AddCategoriesIds>(_updateCategoriesIds);
  }

  _updateCategoriesIds(AddCategoriesIds event, Emitter<TodoState> emit) {
    emit(state.copyWith(categoryIds: event.ids));
  }

  _onStarted(_, Emitter<TodoState> emit) async {
    if (state.status == TodoStatus.success) return;

    try {
      final todoList = await state.todoServices.getAllTodos();
      emit(state.copyWith(
        todos: todoList,
        status: TodoStatus.success,
      ));
    } catch (e) {
      SweetDialogs.unhandleErros(error: '$e');
    }
  }

  _onAddTodo(AddTodo event, Emitter<TodoState> emit) async {
    emit(state.copyWith(status: TodoStatus.loading));
    final todos = state.currentTodos;
    try {
      final todo = event.todo.copyWith(
        hasTime: state.makeTodoStatus == AddTodoStatus.time,
      );
      final id = await state.todoServices.addTodo(todo);
      todo.id = id;
      todos.insert(0, todo);

      emit(state.copyWith(
        status: TodoStatus.success,
        makeTodoStatus: AddTodoStatus.success,
        todos: !state.isFiltered ? todos : state.todos,
        filterTodos: state.isFiltered ? todos : [],
      ));
    } catch (e) {
      SweetDialogs.unhandleErros(error: '$e');
    }
  }

  _onRemoveTodo(
    RemoveTodo event,
    Emitter<TodoState> emit,
  ) async {
    emit(state.copyWith(status: TodoStatus.loading));
    final todos = state.currentTodos;

    try {
      await state.todoServices.deleteTodoById(event.todo.id!);

      todos.remove(event.todo);
      emit(state.copyWith(
        todos: !state.isFiltered ? todos : state.todos,
        status: TodoStatus.success,
        filterTodos: state.isFiltered ? todos : [],
      ));
    } catch (e) {
      SweetDialogs.unhandleErros(error: '$e');
    }
  }

  _onEditTodo(
    EditTodo event,
    Emitter<TodoState> emit,
  ) async {
    emit(state.copyWith(status: TodoStatus.loading));
    final todos = state.currentTodos;
    try {
      final index = todos.indexWhere((todo) => todo.id == event.todo.id);

      if (index != -1) {
        await state.todoServices.updateTodo(event.todo);
        todos[index] = event.todo;
        todos.sort((a, b) {
          final compareDate = a.dueDate != null
              ? a.dueDate!.compareTo(b.dueDate ?? 0)
              : (b.dueDate != null ? -1 : 0);

          return compareDate == 0 ? (a.isDone ? 1 : -1) : compareDate;
        });

        emit(state.copyWith(
          todos: !state.isFiltered ? todos : state.todos,
          filterTodos: state.isFiltered ? todos : [],
          status: TodoStatus.success,
        ));
      } else {
        emit(state.copyWith(status: TodoStatus.error));
      }
    } catch (e) {
      SweetDialogs.unhandleErros(error: '$e');
    }
  }

  _onSaveRawDate(
    SaveRawDate event,
    Emitter<TodoState> emit,
  ) {
    if (state.makeTodoStatus == AddTodoStatus.time) {
      return;
    }
    if (event.hasTime) {
      emit(state.copyWith(
        makeTodoStatus: AddTodoStatus.time,
      ));
    } else {
      emit(state.copyWith(
        makeTodoStatus: AddTodoStatus.date,
      ));
    }
  }

  _onAlterTodo(
    AlterTodo event,
    Emitter<TodoState> emit,
  ) async {
    emit(state.copyWith(status: TodoStatus.loading));
    final todos = state.currentTodos;
    try {
      todos[event.index].isDone = !todos[event.index].isDone;
      await state.todoServices.updateTodo(todos[event.index]);
      todos.sort((todo, other) => todo.isDone && !other.isDone ? 1 : -1);
      emit(state.copyWith(
        todos: !state.isFiltered ? todos : state.todos,
        filterTodos: state.isFiltered ? todos : [],
        status: TodoStatus.success,
      ));
    } catch (e) {
      SweetDialogs.unhandleErros(error: '$e');
    }
  }

  _onFilterTodosByCategories(
    FilterTodosByCategories event,
    Emitter<TodoState> emit,
  ) async {
    emit(state.copyWith(status: TodoStatus.loading));
    try {
      final categoryIds = [...state.categoryIds];
      if (!event.categoryAdd) {
        categoryIds.remove(event.category.id);
      } else {
        categoryIds.add(event.category.id);
      }
      final currentFiltered =
          state.todosByCurrentCategories(updatedCategoryIds: categoryIds);
      if (state.filterStatus != FilterStatus.all) {
        _timeFilters(currentFiltered, state.filterStatus, emit);
        return;
      }
      final caAll = state.maxCategoryIds == categoryIds.length;
      emit(state.copyWith(
        filterTodos: [...currentFiltered],
        status: TodoStatus.success,
        categoryIds: categoryIds,
        filterCS:
            caAll ? FilterCategoryStatus.all : FilterCategoryStatus.filtered,
      ));
    } catch (e) {
      SweetDialogs.unhandleErros(error: '$e');
    }
  }

  _filtersTodos(
    FilterTodos event,
    Emitter<TodoState> emit,
  ) {
    emit(state.copyWith(status: TodoStatus.loading));
    final toFilter = state.todosByCurrentCategories();
    _timeFilters(toFilter, event.filterStatus, emit);
  }

  _timeFilters(
      List<Todo> toFilter, FilterStatus filterStatus, Emitter<TodoState> emit) {
    DateTime today = DateTime.now();
    final todayStart = DateTime(today.year, today.month, today.day, 0, 0, 0);
    final todayEnd = DateTime(today.year, today.month, today.day, 23, 59, 0);
    switch (filterStatus) {
      case FilterStatus.all:
        emit(state.copyWith(
          status: TodoStatus.success,
          filterTodos: toFilter,
          filterStatus: FilterStatus.all,
        ));
        break;
      case FilterStatus.today:
        final doneTodos = _filterAndSortByDueDate(
          todos: toFilter,
          start: todayStart,
          end: todayEnd,
        );
        emit(state.copyWith(
          status: TodoStatus.success,
          filterTodos: [...doneTodos],
          filterStatus: FilterStatus.today,
        ));
        break;
      case FilterStatus.week:
        final endOfWeek = todayEnd.endOfWeek();
        final doneTodos = _filterAndSortByDueDate(
          todos: toFilter,
          start: todayStart,
          end: endOfWeek,
        );
        emit(state.copyWith(
          status: TodoStatus.success,
          filterTodos: [...doneTodos],
          filterStatus: FilterStatus.week,
        ));
        break;
      case FilterStatus.month:
        final endOfMonth = DateTime(
          todayEnd.year,
          todayEnd.month + 1,
          0,
          todayEnd.hour,
          todayEnd.minute,
          todayEnd.second,
        );
        final doneTodos = _filterAndSortByDueDate(
          todos: toFilter,
          start: todayStart,
          end: endOfMonth,
        );
        emit(state.copyWith(
          status: TodoStatus.success,
          filterTodos: [...doneTodos],
          filterStatus: FilterStatus.month,
        ));
        break;
      case FilterStatus.overDue:
        final overdueTodos = toFilter.where(isOverDue).toList();
        emit(state.copyWith(
          status: TodoStatus.success,
          filterTodos: overdueTodos,
          filterStatus: FilterStatus.overDue,
        ));
        break;
      case FilterStatus.done:
        final doneTodos = toFilter.where((todo) => todo.isDone).toList();
        emit(state.copyWith(
          status: TodoStatus.success,
          filterTodos: [...doneTodos],
          filterStatus: FilterStatus.done,
        ));
        break;
    }
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
}
