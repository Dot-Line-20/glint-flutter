import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glint/app/data/module/comment/comment.dart';
import 'package:glint/app/data/module/user/user.dart';
import 'package:glint/app/data/module/comment/controller.dart';
import 'package:glint/app/data/module/user/controller.dart';

class CommentPageController extends GetxController with StateMixin {
  final CommentController commentController = Get.find<CommentController>();
  final UserController userController = Get.find<UserController>();
  final TextEditingController commentTextController = TextEditingController();

  final int postId = int.tryParse(Get.parameters['id'] ?? "") ?? 0;

  List<Comment> get commentList => commentController.commentList;
  List<User> get userList => commentController.userList;

  @override
  void onInit() async {
    super.onInit();
    change(null, status: RxStatus.loading());
    await commentController.getComments(postId);
    change(null, status: RxStatus.success());
  }

  Future<void> addComment() async {
    if (commentTextController.text.isNotEmpty) {
      await commentController.createComment(postId, commentTextController.text);
      commentTextController.clear();
    }
  }
}
