import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:glint/app/data/module/category/category.dart';
import 'package:glint/app/data/module/category/repository.dart';
import 'package:glint/app/widgets/snackbar.dart';

class CategoryController extends GetxController {
  final CategoryRepository repository;

  CategoryController(this.repository);

  final Rx<List<Category>> _categories = Rx([]);
  List<Category> get categories => _categories.value;

  Future<void> getCategories() async {
    try {
      _categories.value = await repository.getCategories();
    } on DioError catch (e) {
      GTSnackBar.open(e.message);
    }
  }

  Future<void> searchCategories(String query) async {
    try {
      _categories.value = await repository.searchCategories(query);
    } on DioError catch (e) {
      GTSnackBar.open(e.message);
    }
  }

  Future<void> createCategory(String name) async {
    try {
      _categories.value = [await repository.createCategory(name)];
    } on DioError catch (e) {
      GTSnackBar.open(e.message);
    }
  }

  @override
  void onInit() async {
    await getCategories();
    super.onInit();
  }
}
