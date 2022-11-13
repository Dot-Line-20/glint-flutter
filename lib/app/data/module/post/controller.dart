import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:glint/app/data/module/post/post.dart';
import 'package:glint/app/data/module/post/repository.dart';
import 'package:glint/app/widgets/snackbar.dart';

class PostController extends GetxController with StateMixin {
  final PostRepository repository;
  PostController(this.repository);

  static PostController get to => Get.find();

  final Rx<List<Post>> _posts = Rx([]);
  final Rx<bool> hasNextPage = true.obs;

  List<Post> get posts => _posts.value;

  Future<void> getPosts(int page, int limit, {bool refresh = false}) async {
    if (refresh) {
      _posts.value = [];
      hasNextPage.value = true;
    }

    if (!refresh && hasNextPage.value == false) {
      return;
    }

    change(null, status: RxStatus.loading());

    try {
      final fetchedPosts = await repository.getPosts(page, limit);
      if (fetchedPosts.isNotEmpty) {
        if (_posts.value.isEmpty) {
          _posts.value = fetchedPosts;
        } else {
          _posts.value.addAll(fetchedPosts);
        }
      } else {
        hasNextPage.value = false;
      }
    } on DioError catch (e) {
      GTSnackBar.open(e.message);
    } finally {
      change(null, status: RxStatus.success());
    }
  }

  Future<void> createPost(
      String title,
      String content,
      FilePickerResult? result,
      Function(int, int) onSendProgress,
      List<int> categoryIds) async {
    if (result == null) {
      //await repository.createPost(title, content, [], categoryIds);
    } else {
      List<int> upload = result.isSinglePick
          ? await repository.uploadFile(result, onSendProgress)
          : await repository.uploadManyFile(result, onSendProgress);
      await Future.wait([
        repository.createPost(title, content, upload, categoryIds),
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
    } on DioError catch (_) {
      print(_.response!.data);
    }
  }

  Future<void> unlikePost(int postId) async {
    try {
      await repository.unlikePost(postId);
    } on DioError catch (_) {
      print(_.response!.data);
    }
  }
}
