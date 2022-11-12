import 'package:get/get.dart';
import 'package:glint/app/data/module/user/user.dart';
import 'package:glint/app/data/module/user/repository.dart';

class UserController extends GetxController with StateMixin<User> {
  final UserRepository repository;
  UserController(this.repository);

  final Rx<User?> _userInfo = Rx(null);
  final Rx<int> _successRate = Rx(0);
  final Rx<Map<int, User>> _users = Rx({});

  User? get userInfo => _userInfo.value;
  int get successRate => _successRate.value;

  @override
  void onInit() {
    getUserInfo();
    //getSucessRate();
    super.onInit();
  }

  getUserInfo() async {
    _userInfo.value = await repository.getUserInfo();
    _users.value[_userInfo.value!.id] = _userInfo.value!;
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

  Future<void> addUsers(List<int> userIds) async {
    for (int userId in userIds) {
      if (!_users.value.containsKey(userId)) {
        _users.value[userId] = await getOtherUserInfo(userId);
      }
    }
  }

  User? getUser(int userId) {
    User? user = _users.value[userId];
    return user;
  }
}
