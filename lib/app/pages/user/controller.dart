import 'package:get/get.dart';
import 'package:glint/app/data/module/user/controller.dart';
import 'package:glint/app/data/module/user/user.dart';

class UserPageController extends GetxController {
  final UserController userController = Get.find<UserController>();

  final int userId = int.parse(Get.parameters["id"]!);

  final Rx<User?> _userInfo = Rx(null);
  final Rx<MetaData?> _metaData = Rx(null);

  User? get userInfo => _userInfo.value;
  MetaData? get metaData => _metaData.value;

  @override
  void onInit() async {
    _userInfo.value = await userController.getUserInfo(userId);
    //_metaData.value = await userController.getUserMetaData(userId);
    super.onInit();
  }
}
