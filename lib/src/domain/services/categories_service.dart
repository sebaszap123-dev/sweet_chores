import 'package:sweet_chores_reloaded/src/config/local/database_notes.dart';
import 'package:sweet_chores_reloaded/src/data/cubits/cubits.dart';
import 'package:sweet_chores_reloaded/src/models/models.dart';
import 'package:sweet_chores_reloaded/src/data/servicelocator.dart';
import 'package:sweet_chores_reloaded/src/domain/repository/repository.dart';

class CategoriesService implements CategoryRepository {
  @override
  DatabaseManagerCubit dbManager = getIt<DatabaseManagerCubit>();

  @override
  Future<int> newCategory(Categories category) async {
    final resp = dbManager.database
        .insert(DatabaseNotes.tbCategories, category.toJson());
    return resp;
  }

  @override
  Future<int> deleteCategory(int id) {
    final resp = dbManager.database
        .delete(DatabaseNotes.tbCategories, where: 'id = ?', whereArgs: [id]);
    return resp;
  }

  @override
  Future<List<Categories>> getAllCategory() async {
    final resp = await dbManager.database.query(DatabaseNotes.tbCategories);
    return resp.isNotEmpty
        ? resp.map((todo) => Categories.fromJson(todo)).toList()
        : <Categories>[];
  }

  @override
  Future<Categories?> getByIdCategory(int id) async {
    final resp = await dbManager.database
        .query(DatabaseNotes.tbCategories, where: 'id = ?', whereArgs: [id]);
    return resp.isNotEmpty ? Categories.fromJson(resp.first) : null;
  }

  @override
  Future<int> updateCategory(Categories category) async {
    final resp = await dbManager.database.update(
        DatabaseNotes.tbCategories, category.toJson(),
        where: 'id = ?', whereArgs: [category.id]);
    return resp;
  }
}
