import 'package:get/get.dart';
import 'package:glint/app/data/models/comment.dart';
import 'package:glint/app/data/module/comment/repository.dart';

class CommentService extends GetxController {
  final CommentRepository repository;

  CommentService(this.repository);

  Future<List<Comment>> getComments(int postId) async {
    return await repository.getComments(postId);
  }

  Future<void> createComment(int postId, String content) async {
    await repository.createComment(postId, content);
  }

  Future<void> updateComment(int postId, int commentId, String content) async {
    await repository.updateComment(postId, commentId, content);
  }

  Future<void> deleteComment(int postId, int commentId) async {
    await repository.deleteComment(postId, commentId);
  }
}
