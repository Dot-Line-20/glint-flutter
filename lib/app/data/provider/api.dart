import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/instance_manager.dart';
import 'package:glint/app/data/models/category.dart';
import 'package:glint/app/data/models/comment.dart';
import 'package:glint/app/data/models/post.dart';
import 'package:glint/app/data/models/schedule.dart';
import 'package:glint/app/data/models/user.dart';
import 'package:glint/app/data/provider/api_interface.dart';
import 'package:glint/app/data/service/auth/service.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class JWTInterceptor extends Interceptor {
  final Dio _dioInstance;

  // Dependency Injection
  JWTInterceptor(this._dioInstance);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (options.path == '/auth/token') {
      return handler.next(options);
    }
    AuthService authService = Get.find<AuthService>();
    if (authService.isAuthenticated) {
      options.headers['Authorization'] = 'Bearer ${authService.accessToken}';
    }

    if (options.path == "/users" && options.method != "POST") {
      options.path = "/users/${authService.userId}";
    }

    if (options.path.startsWith("/schedules")) {
      options.path = "/users/${authService.userId}${options.path}";
    }

    if (options.path.startsWith("/posts") && options.method == "DELETE") {
      options.path += "/${authService.userId}";
    }

    return handler.next(options);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    AuthService authService = Get.find<AuthService>();
    //refresh api가 401시 무한 루프 방지
    if (err.response?.requestOptions.path == '/auth/token') {
      return handler.next(err);
    }

    if (err.response?.statusCode == 400 &&
        authService.accessToken != null &&
        JwtDecoder.isExpired(authService.accessToken!)) {
      try {
        await authService.refreshAcessToken();

        //api 호출을 다시 시도함
        final Response response = await _dioInstance.fetch(err.requestOptions);
        return handler.resolve(response);
      } catch (e) {
        //refresh 실패 시 401을 그대로 반환
        return handler.next(err);
      }
    }
    return handler.next(err);
  }
}

class LogInterceptor extends Interceptor {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    log('${response.requestOptions.method}[${response.statusCode}] => PATH: ${response.requestOptions.path}',
        name: 'DIO');
    handler.next(response);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    if (err.response != null) {
      log('${err.response!.requestOptions.method}[${err.response!.statusCode}] => PATH: ${err.response!.requestOptions.path}',
          name: 'DIO');
    }
    handler.next(err);
  }
}

class GTApiProvider implements GTApiInterface {
  final Dio dio = Dio();
  final baseUrl = "https://h2o.vg";
  final followRedirects = false;

  GTApiProvider() {
    dio.options.baseUrl = baseUrl;
    dio.interceptors.add(LogInterceptor());
    dio.interceptors.add(JWTInterceptor(dio));
  }

  // AUTH
  @override
  Future<Map> login(String email, String password) async {
    String url = '/auth/login';
    Map<String, String> body = {
      "email": email,
      "password": password,
    };
    Response response = await dio.post(url, data: body);
    return response.data;
  }

  @override
  Future<Map> refreshToken(String refreshToken) async {
    String url = '/auth/token';
    Map<String, String> body = {
      "refreshToken": refreshToken,
    };
    Response response = await dio.post(url, data: body);
    return response.data;
  }

  @override
  Future<Map> registerUser(
      String email, String password, String name, String birth) async {
    String url = '/users';
    Map<String, String> body = {
      "email": email,
      "password": password,
      "name": name,
      "birth": birth,
    };
    Response response = await dio.post(url, data: body);
    return response.data;
  }

  // USER
  @override
  Future<User> getUser() async {
    String url = '/users';
    Response response = await dio.get(url);
    return User.fromJson(response.data["data"]);
  }

  @override
  Future<User> getOtherUser(int userId) async {
    String url = '/users/$userId';
    Response response = await dio.get(url);
    return User.fromJson(response.data["data"]);
  }

  @override
  Future<Map> updateUser(String email, String password, String name,
      String birth, String image) async {
    String url = '/users';
    Map<String, String> body = {
      "name": name,
      "birth": birth,
    };
    Response response = await dio.patch(url, data: body);
    return response.data;
  }

  @override
  Future<void> deleteUser(String userId) async {
    String url = '/users/$userId';
    await dio.delete(url);
  }

  // TODO : 고치기
  @override
  Future<int> getSuccessRate() async {
    String url = "/schedules/successRate";
    try {
      Response response = await dio.get(url);
      return response.data["data"]["successRate"];
    } on DioError catch (_) {
      //print(e.response!.data);
      return 0;
    }
  }

  // SCHEDULE
  @override
  Future<Map> makeSchedule(
      String name, String startingAt, String endingAt) async {
    String url = '/schedules';
    Map<String, dynamic> body = {
      "parentScheduleId": null,
      "name": name,
      "startingAt": startingAt,
      "endingAt": endingAt,
    };
    Response response = await dio.post(url, data: body);
    return response.data;
  }

  @override
  Future<List<Schedule>> getScheduleList() async {
    String url = '/schedules';
    Response response = await dio.get(url);
    return (response.data["data"] as List)
        .map<Schedule>((e) => Schedule.fromJson(e))
        .toList();
  }

  @override
  Future<Map> getSchedule(String scheduleId) async {
    String url = '/schedules/$scheduleId';
    Response response = await dio.get(url);
    return response.data;
  }

  @override
  Future<Map> updateSchedule(String scheduleId, String name, String startingAt,
      String endingAt, bool isSuccess) async {
    String url = '/schedules/$scheduleId';
    Map<String, dynamic> body = {
      "parentScheduleId": null,
      "name": name,
      "startingAt": startingAt,
      "endingAt": endingAt,
      "isSuccess": isSuccess,
    };
    Response response = await dio.patch(url, data: body);
    return response.data;
  }

  @override
  Future<void> deleteSchedule(String scheduleId) async {
    String url = '/schedules/$scheduleId';
    await dio.delete(url);
  }

  // POST

  @override
  Future<void> createPost(
      String title, String content, List<int> mediaIds) async {
    String url = "/posts";
    Map<String, dynamic> body = {
      "title": title,
      "content": content,
      "mediaIds": mediaIds,
      "categoryIds": [],
    };
    await dio.post(url, data: body);
  }

  @override
  Future<void> deletePost(int postId) async {
    String url = "/posts/$postId";
    await dio.delete(url);
  }

  @override
  Future<List<Post>> getPosts(int index, int size) async {
    String url = "/posts?page[index]=$index&page[size]=$size";
    Response response = await dio.get(url);
    return (response.data["data"] as List)
        .map<Post>((e) => Post.fromJson(e))
        .toList();
  }

  @override
  Future<void> updatePost(int postId, String title, String content) async {
    String url = "/posts/$postId";
    Map<String, dynamic> body = {
      "title": title,
      "content": content,
    };
    await dio.patch(url, data: body);
  }

  // COMMENT
  @override
  Future<Comment> createComment(int postId, String content) async {
    String url = "/posts/$postId/comments";
    Map<String, dynamic> body = {
      "content": content,
    };
    Response response = await dio.post(url, data: body);
    return Comment.fromJson(response.data["data"]);
  }

  @override
  Future<void> deleteComment(int postId, int commentId) async {
    String url = "/posts/$postId/comments/$commentId";
    await dio.delete(url);
  }

  @override
  Future<void> updateComment(int postId, int commentId, String content) async {
    String url = "/posts/$postId/comments/$commentId";
    Map<String, dynamic> body = {
      "content": content,
    };
    await dio.patch(url, data: body);
  }

  @override
  Future<List<Comment>> getComments(int postId) async {
    String url = "/posts/$postId/comments";
    Response response = await dio.get(url);
    return (response.data["data"] as List)
        .map<Comment>((e) => Comment.fromJson(e))
        .toList();
  }

  // LIKE
  @override
  Future<void> likePost(int postId) async {
    String url = "/posts/$postId/likes";
    await dio.post(url, data: {});
  }

  @override
  Future<void> unlikePost(int postId) async {
    String url = "/posts/$postId/likes";
    await dio.delete(url, data: {});
  }

  // MEDIA
  @override
  Future<void> getFile(String fileId) async {
    String url = "/medias/$fileId";

    Response response = await dio.get(url);
    return response.data["data"];
  }

  @override
  Future<List<int>> uploadFile(
      FilePickerResult result, Function(int, int)? onSendProgress) async {
    String url = "/medias";
    String fileName = result.files.single.name;
    String path = result.files.single.path!;

    FormData formData = FormData.fromMap({
      "media": await MultipartFile.fromFile(path, filename: fileName),
    });

    Response response =
        await dio.post(url, data: formData, onSendProgress: onSendProgress);
    return [response.data["data"]["id"]];
  }

  @override
  Future<List<int>> uploadFileForWeb(
      FilePickerResult result, Function(int, int)? onSendProgress) async {
    String url = "/medias";
    String fileName = result.files.single.name;
    List<int> bytes = result.files.single.bytes!;
    FormData formData = FormData.fromMap({
      "media": MultipartFile.fromBytes(bytes, filename: fileName),
    });

    Response response =
        await dio.post(url, data: formData, onSendProgress: onSendProgress);
    return [response.data["data"]["id"]];
  }

  @override
  Future<List<int>> uploadManyFiles(
      FilePickerResult result, Function(int, int)? onSendProgress) async {
    String url = "/medias/many";
    List<MultipartFile> files = [];
    for (var file in result.files) {
      String fileName = file.name;
      String path = file.path!;

      files.add(await MultipartFile.fromFile(path, filename: fileName));
    }
    FormData formData = FormData.fromMap({
      "files": files,
    });
    Response response =
        await dio.post(url, data: formData, onSendProgress: onSendProgress);
    return (response.data["data"] as List).map<int>((e) => e["id"]).toList();
  }

  @override
  Future<List<int>> uploadManyFilesForWeb(
      FilePickerResult result, Function(int, int)? onSendProgress) async {
    String url = "/medias/many";
    List<MultipartFile> files = [];
    for (PlatformFile file in result.files) {
      String fileName = file.name;
      List<int> bytes = file.bytes!;
      files.add(MultipartFile.fromBytes(bytes, filename: fileName));
    }
    FormData formData = FormData.fromMap({
      "files": files,
    });
    Response response =
        await dio.post(url, data: formData, onSendProgress: onSendProgress);
    return (response.data["data"] as List).map<int>((e) => e["id"]).toList();
  }

  @override
  Future<Category> createCategory(String name) async {
    String url = "/categories";
    Map<String, dynamic> body = {
      "name": name,
    };
    Response response = await dio.post(url, data: body);
    return Category.fromJson(response.data["data"]);
  }

  @override
  Future<Category> getCategorie(int categoryId) async {
    String url = "/categories/$categoryId";
      Response response = await dio.get(url);
    
    return Category.fromJson(response.data["data"]);
  }

  @override
  Future<List<Category>> getCategories() async {
    String url = "/categories";
    Response response = await dio.get(url);
    return (response.data["data"] as List)
        .map<Category>((e) => Category.fromJson(e))
        .toList();
  }
}
