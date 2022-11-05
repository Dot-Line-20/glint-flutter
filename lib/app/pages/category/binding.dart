import 'package:get/get.dart';
import 'package:glint/app/data/module/category/repository.dart';
import 'package:glint/app/data/module/category/service.dart';
import 'package:glint/app/data/module/comment/repository.dart';
import 'package:glint/app/data/module/comment/service.dart';
import 'package:glint/app/data/provider/api.dart';
import 'package:glint/app/pages/category/controller.dart';
import 'package:glint/app/pages/comment/controller.dart';

class CategoryPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CategoryController>(
        () => CategoryController(CategoryRepository(GTApiProvider())));
    Get.lazyPut<CategoryPageController>(() => CategoryPageController());
  }
}
