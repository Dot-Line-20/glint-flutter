import 'package:get/get.dart';
import 'package:glint/app/pages/schedule/controller.dart';

class SchedulePageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SchedulePageController>(() => SchedulePageController());
  }
}
