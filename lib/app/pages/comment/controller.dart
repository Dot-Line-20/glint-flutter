import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glint/app/data/models/comment.dart';
import 'package:glint/app/data/models/user.dart';
import 'package:glint/app/data/module/comment/service.dart';
import 'package:glint/app/data/module/user/service.dart';

class CommentPageController extends GetxController with StateMixin {
  final CommentController commentController = Get.find<CommentController>();
  final UserController userController = Get.find<UserController>();
  final TextEditingController commentTextController = TextEditingController();

  final int postId = int.tryParse(Get.parameters['id'] ?? "") ?? 0;

  @override
  void onInit() async {
    super.onInit();
    change(null, status: RxStatus.loading());
    await getComment();

    change(null, status: RxStatus.success());
  }

  final Rx<List<Comment>> _commentList = Rx([]);
  final Rx<List<User>> _userList = Rx([]);
  List<Comment> get commentList => _commentList.value;
  List<User> get userList => _userList.value;

  List<int> get userIds {
    List<int> userIds = [];
    for (Comment comment in commentList) {
      userIds.add(comment.userId);
    }
    return userIds;
  }

  Future<void> getComment() async {
    _commentList.value = await commentController.getComments(postId);
    _userList.value = await userController.getUserList(userIds);
  }

  Future<void> addComment() async {
    change(null, status: RxStatus.loading());

    Comment comment = await commentController.createComment(
        postId, commentTextController.text);
    User user = (await userController.getOtherUserInfo(comment.userId));
    commentTextController.clear();
    _commentList.value.insert(0, comment);
    _userList.value.insert(0, user);
    change(null, status: RxStatus.success());
  }
}
