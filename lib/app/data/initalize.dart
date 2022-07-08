import 'package:firebase_getx_boilerplate/app/data/controllers/lifecycle.dart';
import 'package:get/get.dart';

class AppInitalizer {
  Future<void> init() async {
    Get.put<LifeCycleController>(LifeCycleController());
  }
}
