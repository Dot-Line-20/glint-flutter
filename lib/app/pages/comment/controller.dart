import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glint/app/data/models/comment.dart';
import 'package:glint/app/data/module/comment/service.dart';

class CommentPageController extends GetxController with StateMixin {
  final CommentController commentController = Get.find<CommentController>();
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
  List<Comment> get commentList => _commentList.value;

  Future<void> getComment() async {
    _commentList.value = await commentController.getComments(postId);
  }

  Future<void> addComment() async {
    change(null, status: RxStatus.loading());

    Comment comment = await commentController.createComment(
        postId, commentTextController.text);
    commentTextController.clear();
    _commentList.value.insert(0, comment);
    change(null, status: RxStatus.success());
  }
}
