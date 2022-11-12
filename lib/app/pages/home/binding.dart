import 'package:get/get.dart';
import 'package:glint/app/data/module/category/repository.dart';
import 'package:glint/app/data/module/category/controller.dart';
import 'package:glint/app/data/module/post/repository.dart';
import 'package:glint/app/data/module/post/controller.dart';
import 'package:glint/app/data/module/schedule/repository.dart';
import 'package:glint/app/data/module/schedule/controller.dart';
import 'package:glint/app/data/module/user/repository.dart';
import 'package:glint/app/data/module/user/controller.dart';
import 'package:glint/app/data/provider/api.dart';
import 'package:glint/app/pages/home/controller.dart';
import 'package:glint/app/pages/schedule/controller.dart';
import 'package:glint/app/pages/sns/controller.dart';
import 'package:glint/app/pages/user/controller.dart';

class HomePageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomePageController>(() => HomePageController());
    Get.put<ScheduleController>(
        ScheduleController(ScheduleRepository(GTApiProvider())));
    Get.put<UserController>(UserController(UserRepository(GTApiProvider())));
    Get.put<PostController>(PostController(PostRepository(GTApiProvider())));
    Get.put<CategoryController>(
        CategoryController(CategoryRepository(GTApiProvider())));

    Get.lazyPut<SnsPageController>(() => SnsPageController());
    Get.lazyPut<SchedulePageController>(() => SchedulePageController());
    Get.lazyPut<UserPageController>(() => UserPageController());
  }
}
