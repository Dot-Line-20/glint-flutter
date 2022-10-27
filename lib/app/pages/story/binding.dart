import 'package:get/get.dart';
import 'package:glint/app/pages/story/controller.dart';

class StoryPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StoryPageController>(() => StoryPageController());
  }
}
