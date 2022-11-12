import 'package:get/get.dart';
import 'package:glint/app/data/module/comment/repository.dart';
import 'package:glint/app/data/module/comment/controller.dart';
import 'package:glint/app/data/provider/api.dart';
import 'package:glint/app/pages/comment/controller.dart';

class CommentPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CommentController>(
        () => CommentController(CommentRepository(GTApiProvider())));
    Get.lazyPut<CommentPageController>(() => CommentPageController());
  }
}
