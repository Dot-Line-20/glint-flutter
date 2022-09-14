import 'package:get/get.dart';
import 'package:glint/app/data/provider/api.dart';
import 'package:glint/app/data/service/auth/repository.dart';
import 'package:glint/app/data/service/auth/service.dart';

class AppInitalizer {
  Future<void> init() async {
    Get.put(AuthService(AuthRepository(FGBPApiProvider())));
    //Get.put<LifeCycleController>(LifeCycleController());
    // await Get.putAsync<DatabaseController>(() => DatabaseController().init());
    // await Get.putAsync<AuthController>(() => AuthController().init());
  }
}
