import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glint/app/data/module/post/post.dart';
import 'package:glint/app/data/module/post/controller.dart';

class SnsPageController extends GetxController {
  final PostController postController = Get.find<PostController>();

  final int _limit = 2;
  final Rx<int> _page = 0.obs;
  final Rx<bool> _isFirstLoadRunning = false.obs;
  final Rx<bool> _isLoadMoreRunning = false.obs;
  final ScrollController scrollController = ScrollController();

  bool get isLoading => _isFirstLoadRunning.value || _isLoadMoreRunning.value;
  List<Post> get posts => postController.posts;

  @override
  onInit() async {
    super.onInit();
    scrollController.addListener(_loadMore);
    _isFirstLoadRunning.value = true;
    await postController.getPosts(_page.value, _limit);
    _isFirstLoadRunning.value = false;
  }

  void _loadMore() async {
    if (_isFirstLoadRunning.value == false &&
        _isLoadMoreRunning.value == false &&
        scrollController.position.extentAfter < 300) {
      _isLoadMoreRunning.value =
          true; // Display a progress indicator at the bottom
      _page.value += 1; // Increase _page by 1
      await postController.getPosts(_page.value, _limit);
      _isLoadMoreRunning.value = false;
    }
  }

  Future<void> refreshPost() async {
    _page.value = 0;
    await postController.getPosts(_page.value, _limit, refresh: true);
  }
}
