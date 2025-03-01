import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sweet_chores/src/config/local/sweet_secure_preferences.dart';
import 'package:sweet_chores/src/core/utils/helpers.dart';
import 'package:sweet_chores/src/core/utils/sweet_chores_dialogs.dart';
import 'package:sweet_chores/src/data/data_source.dart';
import 'package:sweet_chores/src/data/servicelocator.dart';
import 'package:sweet_chores/src/domain/domain.dart';
import 'package:sweet_chores/src/models/models.dart';

part 'sweet_chores_notes_event.dart';
part 'sweet_chores_notes_state.dart';

class SweetChoresNotesBloc
    extends Bloc<SweetChoresNotesEvent, SweetChoresNotesState> {
  SweetChoresNotesBloc() : super(SweetChoresNotesState()) {
    on<StartedChoresEvent>(_onStarted);
    on<RestoreChoresEvent>(_onRestore);
    on<AddChoresEvent>(_onAddTodo);
    on<DateChoresEvent>(_onSaveRawDate);
    on<RemoveChoresEvent>(_onRemoveTodo);
    on<AlterChoresEvent>(_onAlterTodo);
    on<EditChoresEvent>(_onEditTodo);
    on<AddCategoryEvent>(_addCategoryEvent);
    on<EditCategoryEvent>(_editCategoryEvent);
    on<AlterCategoryEvent>(_alterCategoryEvent);
    on<RemoveCategoryEvent>(_removeCategoryEvent);
    on<FilterTimeEvent>(_filterTimeEvent);
  }
  _onStarted(_, Emitter<SweetChoresNotesState> emit) async {
    emit(state.copyWith(status: NotesStatus.loading));
    try {
      final deleteTasks = await SweetSecurePreferences.isActiveAutoDelete;
      if (deleteTasks) {
        final date = await SweetSecurePreferences.nextDeleteDate;
        final now = DateTime.now();
        if (date != null && (date.isSameDay(now) || !now.isBefore(date))) {
          state.todoServices.deleteDonesTodos();
        }
      }

      final todoList = await state.todoServices.getAllTodos();
      List<Categories> categories =
          await state.categoryService.getAllCategory();
      if (categories.isEmpty) {
        await getIt<DatabaseManagerCubit>().toDefaults();
        categories = await state.categoryService.getAllCategory();
      }
      emit(state.copyWith(
        todos: todoList,
        categories: categories,
        status: NotesStatus.success,
        categoryStatus: CategoryStatus.success,
        todoStatus: TodoStatus.success,
      ));
    } catch (e) {
      SweetDialogs.unhandledError(error: '$e');
    }
  }

  _onRestore(
      RestoreChoresEvent event, Emitter<SweetChoresNotesState> emit) async {
    emit(state.copyWith(
        todoStatus: TodoStatus.loading,
        categoryStatus: CategoryStatus.loading));
    emit(state.copyWith(
      status: NotesStatus.success,
      todos: event.todos,
      categories: event.categories,
      todoStatus: TodoStatus.success,
      categoryStatus: CategoryStatus.success,
    ));
  }

  _onAddTodo(AddChoresEvent event, Emitter<SweetChoresNotesState> emit) async {
    emit(state.copyWith(
      todoStatus: TodoStatus.loading,
    ));
    final todos = [...state.todos];
    try {
      final todo = event.todo.copyWith(
        hasTime: state.dateStatus == DateStatus.time,
      );
      final id = await state.todoServices.addTodo(todo);
      todo.id = id;
      todos.insert(0, todo);

      emit(state.copyWith(todoStatus: TodoStatus.success, todos: todos));
    } catch (e) {
      SweetDialogs.unhandledError(error: '$e');
    }
  }

  _onRemoveTodo(
    RemoveChoresEvent event,
    Emitter<SweetChoresNotesState> emit,
  ) async {
    emit(state.copyWith(todoStatus: TodoStatus.loading));
    final todos = [...state.todos];

    try {
      await state.todoServices.deleteTodoById(event.todo.id!);

      todos.remove(event.todo);
      emit(state.copyWith(todos: todos, todoStatus: TodoStatus.success));
    } catch (e) {
      SweetDialogs.unhandledError(error: '$e');
    }
  }

  _onEditTodo(
    EditChoresEvent event,
    Emitter<SweetChoresNotesState> emit,
  ) async {
    emit(state.copyWith(
      todoStatus: TodoStatus.loading,
    ));
    final todos = [...state.todos];
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
          todos: todos,
          todoStatus: TodoStatus.success,
        ));
      } else {
        emit(state.copyWith(todoStatus: TodoStatus.error));
      }
    } catch (e) {
      SweetDialogs.unhandledError(error: '$e');
    }
  }

  _onSaveRawDate(
    DateChoresEvent event,
    Emitter<SweetChoresNotesState> emit,
  ) {
    if (event.hasTime) {
      emit(state.copyWith(
        dateStatus: DateStatus.time,
      ));
    } else {
      emit(state.copyWith(
        dateStatus: DateStatus.date,
      ));
    }
  }

  _onAlterTodo(
    AlterChoresEvent event,
    Emitter<SweetChoresNotesState> emit,
  ) async {
    emit(state.copyWith(
      todoStatus: TodoStatus.loading,
    ));
    final todos = [...state.todos];
    try {
      final index = todos.indexOf(event.index);
      if (index != -1) {
        todos[index].isDone = !todos[index].isDone;
        await state.todoServices.updateTodo(todos[index]);
        emit(state.copyWith(
          todos: todos,
          todoStatus: TodoStatus.success,
        ));
      }
    } catch (e) {
      SweetDialogs.unhandledError(error: '$e');
    }
  }

  // * CATEGORIES
  _addCategoryEvent(
      AddCategoryEvent event, Emitter<SweetChoresNotesState> emit) async {
    emit(state.copyWith(categoryStatus: CategoryStatus.loading));
    try {
      final temp = [...state.categories];
      final categoryID =
          await state.categoryService.newCategory(event.category);
      event.category.id = categoryID;
      temp.add(event.category);
      emit(state.copyWith(
          categories: temp, categoryStatus: CategoryStatus.success));
    } catch (e) {
      emit(state.copyWith(categoryStatus: CategoryStatus.error));
      SweetDialogs.unhandledError(error: '$e');
    }
  }

  _editCategoryEvent(
      EditCategoryEvent event, Emitter<SweetChoresNotesState> emit) async {
    emit(state.copyWith(categoryStatus: CategoryStatus.loading));
    try {
      await state.categoryService.updateCategory(event.category);
      final temp = [...state.categories];
      final oldCategory = temp.where((ca) => ca.id == event.category.id);
      final index = temp.indexOf(oldCategory.first);
      temp[index] = event.category;
      emit(state.copyWith(
          categories: temp, categoryStatus: CategoryStatus.success));
    } catch (e) {
      emit(state.copyWith(categoryStatus: CategoryStatus.error));
      SweetDialogs.unhandledError(error: '$e');
    }
  }

  _alterCategoryEvent(
      AlterCategoryEvent event, Emitter<SweetChoresNotesState> emit) async {
    try {
      emit(state.copyWith(categoryStatus: CategoryStatus.loading));
      final temp = [...state.categories];
      final index =
          temp.indexWhere((category) => category.id == event.category.id);

      if (index != -1) {
        temp[index] = event.category;
        emit(state.copyWith(
            categories: temp, categoryStatus: CategoryStatus.success));
      } else {
        emit(state.copyWith(categoryStatus: CategoryStatus.error));
        throw Exception("Category not found");
      }
    } catch (e) {
      emit(state.copyWith(categoryStatus: CategoryStatus.error));
      SweetDialogs.unhandledError(error: '$e');
    }
  }

  _removeCategoryEvent(
      RemoveCategoryEvent event, Emitter<SweetChoresNotesState> emit) async {
    emit(state.copyWith(categoryStatus: CategoryStatus.loading));
    try {
      await state.categoryService.deleteCategory(event.category.id);
      state.categories.remove(event.category);
      emit(state.copyWith(
          categories: state.categories,
          categoryStatus: CategoryStatus.success));
    } catch (e) {
      emit(state.copyWith(categoryStatus: CategoryStatus.error));
      SweetDialogs.unhandledError(error: '$e');
    }
  }

  _filterTimeEvent(
      FilterTimeEvent event, Emitter<SweetChoresNotesState> emit) async {
    emit(state.copyWith(filterStatus: event.time));
  }
}
