import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:glint/app/data/module/user/user.dart';
import 'package:glint/app/data/module/user/repository.dart';
import 'package:glint/app/widgets/snackbar.dart';

class UserController extends GetxController with StateMixin<User> {
  final UserRepository repository;
  UserController(this.repository);

  final Rx<User?> _userInfo = Rx(null);
  final Rx<MetaData?> _metaData = Rx(null);
  final Rx<int> _successRate = Rx(0);

  User? get userInfo => _userInfo.value;
  MetaData? get metaData => _metaData.value;
  int get successRate => _successRate.value;

  @override
  void onInit() {
    getUserInfo();
    //getMetaData();
    //getSucessRate();
    super.onInit();
  }

  void getUserInfo() async {
    try {
      _userInfo.value = await repository.getUserInfo();
      change(_userInfo.value, status: RxStatus.success());
    } on DioError catch (e) {
      GTSnackBar.open(e.message);
      print(e.response!.data);
    }
  }

  getMetaData() async {
    try {
      _metaData.value = await repository.getMetaData();
    } on DioError catch (e) {
      GTSnackBar.open(e.message);
      print(e.response!.data);
    }
  }

  getSucessRate() async {
    _successRate.value = await repository.getSuccessRate();
  }

  Future<User> getOtherUserInfo(int userId) async {
    return repository.getOtherUserInfo(userId);
  }

  Future<List<User>> getUserList(List<int> userIds) async {
    List<User> users = [];
    for (int userId in userIds) {
      users.add(await getOtherUserInfo(userId));
    }
    return users;
  }
}
