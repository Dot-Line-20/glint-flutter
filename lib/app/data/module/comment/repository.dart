import 'package:glint/app/data/models/comment.dart';
import 'package:glint/app/data/provider/api_interface.dart';

class CommentRepository {
  final GTApiInterface api;

  CommentRepository(this.api);

  Future<List<Comment>> getComments(int postId) async {
    return api.getComments(postId);
  }

  Future<Comment> createComment(int postId, String content) =>
      api.createComment(postId, content);
  Future<void> updateComment(int postId, int commentId, String content) async {
    await api.updateComment(postId, commentId, content);
  }

  Future<void> deleteComment(int postId, int commentId) async {
    await api.deleteComment(postId, commentId);
  }
}
