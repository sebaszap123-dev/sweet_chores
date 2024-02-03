import 'package:sweet_chores/src/config/local/database_notes.dart';
import 'package:sweet_chores/src/data/cubits/cubits.dart';
import 'package:sweet_chores/src/models/models.dart';
import 'package:sweet_chores/src/data/servicelocator.dart';
import 'package:sweet_chores/src/domain/repository/repository.dart';

class CategoriesService implements CategoryRepository {
  @override
  DatabaseManagerCubit dbManager = getIt<DatabaseManagerCubit>();

  @override
  Future<int> newCategory(Categories category) async {
    final resp = dbManager.state.db
        .insert(DatabaseNotes.tbCategories, category.toJsonSql());
    return resp;
  }

  @override
  Future<int> deleteCategory(int id) {
    final resp = dbManager.state.db
        .delete(DatabaseNotes.tbCategories, where: 'id = ?', whereArgs: [id]);
    return resp;
  }

  @override
  Future<List<Categories>> getAllCategory() async {
    final resp = await dbManager.state.db.query(DatabaseNotes.tbCategories);
    return resp.isNotEmpty
        ? resp.map((todo) => Categories.fromJson(todo)).toList()
        : <Categories>[];
  }

  @override
  Future<Categories?> getByIdCategory(int id) async {
    final resp = await dbManager.state.db
        .query(DatabaseNotes.tbCategories, where: 'id = ?', whereArgs: [id]);
    return resp.isNotEmpty ? Categories.fromJson(resp.first) : null;
  }

  @override
  Future<int> updateCategory(Categories category) async {
    final resp = await dbManager.state.db.update(
        DatabaseNotes.tbCategories, category.toJson(),
        where: 'id = ?', whereArgs: [category.id]);
    return resp;
  }
}
