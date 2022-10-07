import 'package:glint/app/pages/sns/controller.dart';
import 'package:get/get.dart';

class SnsPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SnsPageController>(() => SnsPageController());
  }
}
