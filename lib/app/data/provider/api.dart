import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:file_picker/src/file_picker_result.dart';
import 'package:get/instance_manager.dart';
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

  @override
  Future<int> getSuccessRate() async {
    String url = "/schedules/successRate";
    try {
      Response response = await dio.get(url);
      return response.data["data"]["successRate"];
    } on DioError catch (e) {
      print(e.response!.data);
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
  Future<void> createPost(String title, String content) async {
    String url = "/posts";
    Map<String, dynamic> body = {
      "title": title,
      "content": content,
    };
    await dio.post(url, data: body);
  }

  @override
  Future<void> deletePost(int postId) async {
    String url = "/posts/$postId";
    await dio.delete(url);
  }

  @override
  Future<List<Post>> getPosts() async {
    String url = "/posts";
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
  Future<void> createComment(int postId, String content) async {
    String url = "/posts/$postId/comments";
    Map<String, dynamic> body = {
      "content": content,
    };
    await dio.post(url, data: body);
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
    String url = "/posts/$postId/like";
    await dio.post(url);
  }

  @override
  Future<void> unlikePost(int postId) async {
    String url = "/posts/$postId/like";
    await dio.delete(url);
  }

  // MEDIA
  @override
  Future<void> getFile(String fileId) async {
    String url = "/medias/$fileId";

    Response response = await dio.get(url);
    return response.data["data"];
  }

  @override
  Future<void> uploadFile(FilePickerResult result) async {
    String url = "/media";
    String fileName = result.files.single.name;
    String path = result.files.single.path!;
    FormData formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(path, filename: fileName),
    });
    await dio.post(url, data: formData);
  }

  @override
  Future<void> uploadManyFiles(FilePickerResult result) async {
    String url = "/media/many";
    List<MultipartFile> files = [];
    for (var file in result.files) {
      String fileName = file.name;
      String path = file.path!;
      files.add(await MultipartFile.fromFile(path, filename: fileName));
    }
    FormData formData = FormData.fromMap({
      "files": files,
    });
    await dio.post(url, data: formData);
  }
}
