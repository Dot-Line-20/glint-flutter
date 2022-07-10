import 'package:firebase_getx_boilerplate/app/data/controllers/lifecycle.dart';
import 'package:firebase_getx_boilerplate/app/firebase/auth.dart';
import 'package:firebase_getx_boilerplate/app/firebase/data_document.dart';
import 'package:get/get.dart';

class AppInitalizer {
  Future<void> init() async {
    Get.put<LifeCycleController>(LifeCycleController());
    await Get.putAsync<DatabaseController>(() => DatabaseController().init());
    await Get.putAsync<AuthController>(() => AuthController().init());
  }
}
