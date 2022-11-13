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

  static CommentController get to => Get.find();

  final UserController userController = Get.find<UserController>();

  final Rx<List<Comment>> _commentList = Rx([]);

  List<Comment> get commentList => _commentList.value;

  Future<void> getComments(int postId) async {
    change(null, status: RxStatus.loading());

    try {
      _commentList.value = await repository.getComments(postId);
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
      _commentList.refresh();
    } on DioError catch (e) {
      GTSnackBar.open(e.message);
      print(e.response!.data);
    } finally {
      change(null, status: RxStatus.success());
    }
  }

  Future<void> deleteComment(int postId, int commentId) async {
    change(null, status: RxStatus.loading());
    try {
      await repository.deleteComment(postId, commentId);
      _commentList.value.removeWhere((comment) => comment.id == commentId);
      print("Comment deleted ${commentList}");
      _commentList.refresh();
    } on DioError catch (e) {
      GTSnackBar.open(e.message);
      print(e.response!.data);
    } finally {
      change(null, status: RxStatus.success());
    }
  }
}
