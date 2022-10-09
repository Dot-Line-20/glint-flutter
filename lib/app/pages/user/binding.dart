import 'package:glint/app/pages/sns/controller.dart';
import 'package:get/get.dart';
import 'package:glint/app/pages/user/controller.dart';

class UserPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserPageController>(() => UserPageController());
  }
}
