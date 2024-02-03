part of 'categories_bloc.dart';

abstract class CategoriesEvent extends Equatable {
  const CategoriesEvent();

  @override
  List<Object?> get props => [];
}

class CategoryStarted extends CategoriesEvent {
  final List<Categories> categories;
  const CategoryStarted({this.categories = const []});
  @override
  List<Object> get props => [categories];
}

class AddCategory extends CategoriesEvent {
  final Categories category;
  const AddCategory(this.category);

  @override
  List<Object> get props => [category];
}

class RemoveCategory extends CategoriesEvent {
  final Categories category;
  const RemoveCategory(this.category);

  @override
  List<Object> get props => [category];
}

class AlterCategory extends CategoriesEvent {
  final Categories category;
  const AlterCategory(this.category);

  @override
  List<Object?> get props => [category];
}

class UpdateCategoryStatus extends CategoriesEvent {
  final Categories category;
  const UpdateCategoryStatus(this.category);

  @override
  List<Object?> get props => [category];
}

class RestoreCategoriesBackup extends CategoriesEvent {
  final List<Categories> categories;
  const RestoreCategoriesBackup(this.categories);

  @override
  List<Object?> get props => [categories];
}
