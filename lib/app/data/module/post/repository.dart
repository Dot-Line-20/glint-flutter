import 'package:glint/app/data/models/post.dart';
import 'package:glint/app/data/provider/api_interface.dart';

class PostRepository {
  final GTApiInterface api;

  PostRepository(this.api);

  Future<List<Post>> getPosts() async {
    final response = await api.getPosts();
    return response;
  }

  Future<void> createPost(String title, String content) async {
    await api.createPost(title, content);
  }

  Future<void> updatePost(int postId, String title, String content) async {
    await api.updatePost(postId, title, content);
  }

  Future<void> deletePost(int postId) async {
    await api.deletePost(postId);
  }

  Future<void> likePost(int postId) async {
    await api.likePost(postId);
  }

  Future<void> unlikePost(int postId) async {
    await api.unlikePost(postId);
  }
}
