import 'package:glint/app/data/module/category/category.dart';
import 'package:glint/app/data/provider/api_interface.dart';

class CategoryRepository {
  final GTApiInterface api;
  CategoryRepository(this.api);

  Future<List<Category>> getCategories() async {
    return await api.getCategories("");
  }

  Future<List<Category>> searchCategories(String query) async {
    return await api.getCategories(query);
  }

  Future<Category> createCategory(String name) async {
    return await api.createCategory(name);
  }
}
