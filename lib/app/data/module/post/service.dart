import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:glint/app/data/models/post.dart';
import 'package:glint/app/data/module/post/repository.dart';

class PostController extends GetxController {
  final PostRepository repository;

  PostController(this.repository);

  Future<List<Post>> getPosts(int page, int limit) async {
    return await repository.getPosts(page, limit);
  }

  Future<void> createPost(String title, String content,
      FilePickerResult? result, Function(int, int) onSendProgress) async {
    if (result == null) {
      await repository.createPost(title, content, []);
    } else {
      List<int> upload = result.isSinglePick
          ? await repository.uploadFile(result, onSendProgress)
          : await repository.uploadManyFile(result);
      await Future.wait([
        repository.createPost(title, content, upload),
      ]);
    }
  }

  Future<void> updatePost(int postId, String title, String content) async {
    await repository.updatePost(postId, title, content);
  }

  Future<void> deletePost(int postId) async {
    await repository.deletePost(postId);
  }

  Future<void> likePost(int postId) async {
    try {
      await repository.likePost(postId);
    } on DioError catch (e) {
      print(e.response!.data);
    }
  }

  Future<void> unlikePost(int postId) async {
    try {
      await repository.unlikePost(postId);
    } on DioError catch (e) {
      print(e.response!.data);
    }
  }
}
