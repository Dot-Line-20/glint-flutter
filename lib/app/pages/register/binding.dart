import 'package:get/get.dart';
import 'package:glint/app/pages/register/controller.dart';

class RegisterPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterPageController>(() => RegisterPageController());
  }
}
