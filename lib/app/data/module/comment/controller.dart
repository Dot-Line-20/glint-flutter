import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:glint/app/data/module/comment/comment.dart';
import 'package:glint/app/data/module/comment/repository.dart';
import 'package:glint/app/data/module/user/controller.dart';
import 'package:glint/app/data/module/user/user.dart';
import 'package:glint/app/widgets/snackbar.dart';

class CommentController extends GetxController with StateMixin {
  final CommentRepository repository;
  CommentController(this.repository);

  final UserController userController = Get.find<UserController>();

  final Rx<List<Comment>> _commentList = Rx([]);
  final Rx<List<User>> _userList = Rx([]);

  List<Comment> get commentList => _commentList.value;
  List<User> get userList => _userList.value;

  Future<void> getComments(int postId) async {
    change(null, status: RxStatus.loading());

    try {
      _commentList.value = await repository.getComments(postId);
      _userList.value = await userController.getUserList(
          _commentList.value.map((comment) => comment.userId).toList());
    } on DioError catch (e) {
      GTSnackBar.open(e.message);
      print(e.response!.data);
    } finally {
      change(null, status: RxStatus.success());
    }
  }

  Future<void> createComment(int postId, String content) async {
    change(null, status: RxStatus.loading());
    try {
      Comment comment = await repository.createComment(postId, content);
      _commentList.value.add(comment);
    } on DioError catch (e) {
      GTSnackBar.open(e.message);
      print(e.response!.data);
    } finally {
      change(null, status: RxStatus.success());
    }
  }

  Future<void> updateComment(int postId, int commentId, String content) async {
    await repository.updateComment(postId, commentId, content);
  }

  Future<void> deleteComment(int postId, int commentId) async {
    await repository.deleteComment(postId, commentId);
  }
}
