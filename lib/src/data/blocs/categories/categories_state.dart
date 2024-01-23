part of 'categories_bloc.dart';

enum CategoriesStatus { initial, success, error, loading }

class CategoriesState extends Equatable {
  final List<Categories> categories;
  final CategoriesStatus status;
  final CategoriesService categoryService = CategoriesService();
  CategoriesState({
    this.categories = const [],
    this.status = CategoriesStatus.initial,
  });

  @override
  List<Object> get props => [categories, status];

  CategoriesState copyWith(
      {CategoriesStatus? status, List<Categories>? categories}) {
    return CategoriesState(
      categories: categories ?? this.categories,
      status: status ?? this.status,
    );
  }

  Categories getCategory(int id) {
    final category = categories.firstWhere((category) => category.id == id,
        orElse: () => Categories(name: 'to-do'));
    return category;
  }
}
