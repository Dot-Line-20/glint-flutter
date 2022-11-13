import 'package:glint/app/pages/feed/controller.dart';
import 'package:get/get.dart';

class FeedPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FeedPageController>(() => FeedPageController());
  }
}
