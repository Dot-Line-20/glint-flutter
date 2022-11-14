import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:glint/app/data/module/user/user.dart';
import 'package:glint/app/data/module/user/repository.dart';
import 'package:glint/app/data/service/auth/service.dart';
import 'package:glint/app/widgets/snackbar.dart';

class UserController extends GetxController with StateMixin<User> {
  final UserRepository repository;
  UserController(this.repository);

  static UserController get to => Get.find();

  final Rx<User?> _userInfo = Rx(null);
  final Rx<MetaData?> _metaData = Rx(null);

  User? get userInfo => _userInfo.value;
  MetaData? get metaData => _metaData.value;

  @override
  void onInit() {
    getMyData();
    super.onInit();
  }

  Future<void> getMyData() async {
    int? userId = int.tryParse(Get.find<AuthService>().userId ?? "");
    _userInfo.value = await getUserInfo(userId ?? 0);
    // _metaData.value = await getUserMetaData(userId ?? 0);
  }

  Future<User> getUserInfo(int userId) async {
    User user = await repository.getUserInfo(userId);
    return user;
  }

  Future<MetaData> getUserMetaData(int userId) async {
    MetaData metaData = await repository.getMetaData(userId);
    return metaData;
  }
}
