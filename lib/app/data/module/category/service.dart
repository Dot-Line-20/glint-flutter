import 'package:get/get.dart';
import 'package:glint/app/data/models/category.dart';
import 'package:glint/app/data/module/category/repository.dart';

class CategoryController extends GetxController {
  final CategoryRepository repository;

  CategoryController(this.repository);

  Future<List<Category>> getCategories() async {
    return await repository.getCategories();
  }

  Future<List<Category>> searchCategories(String query) async {
    return await repository.searchCategories(query);
  }

  Future<Category> createCategory(String name) async {
    return repository.createCategory(name);
  }
}
