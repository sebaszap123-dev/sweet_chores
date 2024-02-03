import 'package:sweet_chores/src/config/local/database_notes.dart';
import 'package:sweet_chores/src/data/cubits/database/database_manager_cubit.dart';
import 'package:sweet_chores/src/models/categories.dart';

abstract class CategoryRepository extends DatabaseNotes {
  DatabaseManagerCubit dbManager;
  CategoryRepository(this.dbManager);

  /// Create a New Category
  Future<int> newCategory(Categories category);

  /// Delete Category
  Future<int> deleteCategory(int id);

  /// Get all Categories
  Future<List<Categories>> getAllCategory();

  /// Get Category by and id
  Future<Categories?> getByIdCategory(int id);

  Future<int> updateCategory(Categories category);
}
