import 'package:get/get.dart';
import 'package:glint/app/data/models/category.dart';
import 'package:glint/app/data/module/category/repository.dart';

class CategoryController extends GetxController {
  final CategoryRepository repository;

  CategoryController(this.repository);

  @override
  void onInit() {
    super.onInit();
  }

  Future<List<Category>> getCategories() async {
    return await repository.getCategories();
  }

  Future<Category> createCategory(String name) async {
    return repository.createCategory(name);
  }
}
