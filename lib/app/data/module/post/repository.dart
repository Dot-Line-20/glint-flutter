import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:glint/app/data/models/post.dart';
import 'package:glint/app/data/provider/api_interface.dart';

class PostRepository {
  final GTApiInterface api;

  PostRepository(this.api);

  Future<List<Post>> getPosts(int page, int limit) async {
    final response = await api.getPosts(page, limit);
    return response;
  }

  Future<void> createPost(String title, String content, List<int> mediaIds,
      List<int> categoryIds) async {
    await api.createPost(title, content, mediaIds, categoryIds);
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

  Future<List<int>> uploadFile(
      FilePickerResult result, Function(int, int)? onSendProgress) {
    if (GetPlatform.isWeb) {
      return api.uploadFileForWeb(result, onSendProgress);
    }
    return api.uploadFile(result, onSendProgress);
  }

  Future<List<int>> uploadManyFile(
      FilePickerResult result, Function(int, int)? onSendProgress) {
    if (GetPlatform.isWeb) {
      return api.uploadManyFilesForWeb(result, onSendProgress);
    }
    return api.uploadManyFiles(result, onSendProgress);
  }
}
