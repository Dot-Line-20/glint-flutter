import 'package:glint/app/data/models/category.dart';
import 'package:glint/app/data/provider/api_interface.dart';

class CategoryRepository {
  final GTApiInterface api;
  CategoryRepository(this.api);

  Future<List<Category>> getCategories() async {
    return await api.getCategories();
  }

  Future<Category> createCategory(String name) async {
    return await api.createCategory(name);
  }
}
