import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glint/app/data/module/comment/comment.dart';
import 'package:glint/app/data/module/comment/controller.dart';

class CommentPageController extends GetxController with StateMixin {
  final CommentController commentController = Get.find<CommentController>();
  final TextEditingController commentTextController = TextEditingController();

  final int postId = int.tryParse(Get.parameters['id'] ?? "") ?? 0;

  List<Comment> get commentList => commentController.commentList;

  @override
  void onInit() async {
    super.onInit();
    await commentController.getComments(postId);
    change(null, status: RxStatus.success());
  }

  Future<void> addComment() async {
    if (commentTextController.text.isNotEmpty) {
      await commentController.createComment(postId, commentTextController.text);
      commentTextController.clear();
    }
  }

  Future<void> deleteComment(int commentId) async {
    await commentController.deleteComment(postId, commentId);
  }
}
