import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glint/app/test/test_api.dart';
import 'package:glint/app/test/test_model.dart';

class SnsPageController extends GetxController with StateMixin {
  TestApi testApi = TestApi();
  ImageApi imageApi = ImageApi();
  final int _limit = 10;
  final Rx<int> _page = 0.obs;

  final Rx<bool> _isFirstLoadRunning = false.obs;
  final Rx<bool> _hasNextPage = true.obs;

  final Rx<bool> _isLoadMoreRunning = false.obs;
  final ScrollController scrollController = ScrollController();
  final Rx<List<TestPost>> _posts = Rx([]);

  bool get isLoading => _isFirstLoadRunning.value || _isLoadMoreRunning.value;
  List<TestPost> get posts => _posts.value;

  @override
  onInit() async {
    super.onInit();
    change(null, status: RxStatus.loading());
    scrollController.addListener(_loadMore);
    _isFirstLoadRunning.value = true;
    _posts.value = await testApi.fetchPosts(_page.value, _limit);
    _isFirstLoadRunning.value = false;
    change(null, status: RxStatus.success());
  }

  void _loadMore() async {
    if (_hasNextPage.value == true &&
        _isFirstLoadRunning.value == false &&
        _isLoadMoreRunning.value == false &&
        scrollController.position.extentAfter < 300) {
      _isLoadMoreRunning.value =
          true; // Display a progress indicator at the bottom
      _page.value += 1; // Increase _page by 1

      try {
        List<TestPost> fetchedPosts =
            await testApi.fetchPosts(_page.value, _limit);

        if (fetchedPosts.isNotEmpty) {
          _posts.value.addAll(fetchedPosts);
        } else {
          _hasNextPage.value = false;
        }
      } finally {
        _isLoadMoreRunning.value = false;
      }
    }
  }
}
