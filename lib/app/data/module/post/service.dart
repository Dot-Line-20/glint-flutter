import 'package:get/get.dart';
import 'package:glint/app/data/models/post.dart';
import 'package:glint/app/data/module/post/repository.dart';

class PostService extends GetxController {
  final PostRepository repository;

  PostService(this.repository);

  Future<List<Post>> getPosts() async {
    return await repository.getPosts();
  }

  Future<void> createPost(String title, String content) async {
    await repository.createPost(title, content);
  }

  Future<void> updatePost(int postId, String title, String content) async {
    await repository.updatePost(postId, title, content);
  }

  Future<void> deletePost(int postId) async {
    await repository.deletePost(postId);
  }
}
