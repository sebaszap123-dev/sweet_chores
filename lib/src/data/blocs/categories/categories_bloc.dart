import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sweet_chores/src/core/utils/sweet_chores_dialogs.dart';
import 'package:sweet_chores/src/data/data_source.dart';
import 'package:sweet_chores/src/data/servicelocator.dart';
import 'package:sweet_chores/src/models/models.dart';
import 'package:sweet_chores/src/domain/services/categories_service.dart';

part 'categories_event.dart';
part 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  CategoriesBloc() : super(CategoriesState()) {
    on<CategoryStarted>(_startedEvent);
    on<AddCategory>(_addEvent);
    on<AlterCategory>(_alterEvent);
    on<UpdateCategoryStatus>(_changeStatusEvent);
    on<RemoveCategory>(_removeEvent);
    on<RestoreCategoriesBackup>(_restoreFromBackup);
  }

  _startedEvent(CategoryStarted event, Emitter<CategoriesState> emit) async {
    if (!event.forceReload && state.status == CategoriesStatus.success) return;
    emit(state.copyWith(status: CategoriesStatus.loading));
    try {
      final categories = await state.categoryService.getAllCategory();
      final ids = categories.map((ca) => ca.id).toList();
      getIt<TodoBloc>().add(AddCategoriesIds(ids: ids));
      emit(state.copyWith(
          categories: categories, status: CategoriesStatus.success));
    } catch (e) {
      emit(state.copyWith(status: CategoriesStatus.error));
      SweetDialogs.unhandleErros(error: '$e');
    }
  }

  _addEvent(AddCategory event, Emitter<CategoriesState> emit) async {
    emit(state.copyWith(status: CategoriesStatus.loading));
    try {
      List<Categories> temp = [];
      temp.addAll(state.categories);
      final categoryID =
          await state.categoryService.newCategory(event.category);
      event.category.id = categoryID;
      temp.add(event.category);
      emit(state.copyWith(categories: temp, status: CategoriesStatus.success));
    } catch (e) {
      emit(state.copyWith(status: CategoriesStatus.error));
      SweetDialogs.unhandleErros(error: '$e');
    }
  }

  _alterEvent(AlterCategory event, Emitter<CategoriesState> emit) async {
    emit(state.copyWith(status: CategoriesStatus.loading));
    try {
      await state.categoryService.updateCategory(event.category);
      final temp = state.categories;
      final oldCategory = temp.where((ca) => ca.id == event.category.id);
      final index = temp.indexOf(oldCategory.first);
      temp[index] = event.category;
      emit(state.copyWith(categories: temp, status: CategoriesStatus.success));
    } catch (e) {
      emit(state.copyWith(status: CategoriesStatus.error));
      SweetDialogs.unhandleErros(error: '$e');
    }
  }

  _changeStatusEvent(
      UpdateCategoryStatus event, Emitter<CategoriesState> emit) async {
    try {
      emit(state.copyWith(status: CategoriesStatus.loading));
      final temp = List.of(state.categories);
      final index =
          temp.indexWhere((category) => category.id == event.category.id);

      if (index != -1) {
        temp[index].isActive = !temp[index].isActive;
        final actives = temp.where((e) => e.isActive).toList();

        if (actives.isEmpty) {
          emit(state.copyWith(status: CategoriesStatus.success));
        } else {
          emit(state.copyWith(
              categories: temp, status: CategoriesStatus.success));
        }
      } else {
        emit(state.copyWith(status: CategoriesStatus.error));
        throw Exception("Category not found");
      }
    } catch (e) {
      emit(state.copyWith(status: CategoriesStatus.error));
      SweetDialogs.unhandleErros(error: '$e');
    }
  }

  _removeEvent(RemoveCategory event, Emitter<CategoriesState> emit) async {
    emit(state.copyWith(status: CategoriesStatus.loading));
    try {
      await state.categoryService.deleteCategory(event.category.id);
      state.categories.remove(event.category);
      emit(state.copyWith(
          categories: state.categories, status: CategoriesStatus.success));
    } catch (e) {
      emit(state.copyWith(status: CategoriesStatus.error));
      SweetDialogs.unhandleErros(error: '$e');
    }
  }

  _restoreFromBackup(
      RestoreCategoriesBackup event, Emitter<CategoriesState> emit) async {
    emit(state.copyWith(status: CategoriesStatus.loading));
    emit(state.copyWith(
        categories: event.categories, status: CategoriesStatus.success));
  }
}
