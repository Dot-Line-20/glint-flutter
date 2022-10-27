import 'package:get/get.dart';
import 'package:glint/app/test/test_model.dart';

class TestApi extends GetConnect {
  Future<List<TestPost>> fetchPosts(int page, int limit) async {
    String url = "https://jsonplaceholder.typicode.com/posts";
    Response response = await get("$url?_page=$page&_limit=$limit");
    //print(response.body);
    return response.body
        .map<TestPost>((post) => TestPost.fromJson(post))
        .toList();
  }
}

class ImageApi extends GetConnect {
  @override
  final String? baseUrl = "https://source.unsplash.com/random/";

  Future<String> getImage(int count) async {
    return "$baseUrl/$count";
  }
}
