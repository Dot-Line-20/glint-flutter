import 'package:get/get.dart';
import 'package:glint/app/data/models/user.dart';
import 'package:glint/app/data/module/user/repository.dart';

class UserController extends GetxController with StateMixin<User> {
  final UserRepository repository;
  UserController(this.repository);

  final Rx<User?> _userInfo = Rx(null);
  final Rx<int> _successRate = Rx(0);

  User? get userInfo => _userInfo.value;
  int get successRate => _successRate.value;

  @override
  void onInit() {
    getUserInfo();
    getSucessRate();
    super.onInit();
  }

  getUserInfo() async {
    _userInfo.value = await repository.getUserInfo();
  }

  getSucessRate() async {
    _successRate.value = await repository.getSuccessRate();
  }
}
