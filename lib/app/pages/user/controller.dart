import 'package:get/get.dart';
import 'package:glint/app/data/module/user/user.dart';
import 'package:glint/app/data/module/user/controller.dart';

class UserPageController extends GetxController {
  final UserController userController = Get.find<UserController>();
  final Rx<Map<int, User>> users = Rx({});

  Future<void> addUsers(List<int> userIds) async {
    for (int userId in userIds) {
      if (!users.value.containsKey(userId)) {
        users.value[userId] = await userController.getOtherUserInfo(userId);
      }
    }
  }
}
