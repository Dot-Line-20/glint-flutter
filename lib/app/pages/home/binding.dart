import 'package:get/get.dart';
import 'package:glint/app/data/module/schedule/repository.dart';
import 'package:glint/app/data/module/schedule/service.dart';
import 'package:glint/app/data/provider/api.dart';
import 'package:glint/app/pages/home/controller.dart';

class HomePageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomePageController>(() => HomePageController());
    Get.put<ScheduleController>(
        ScheduleController(ScheduleRepository(GTApiProvider())));
  }
}
