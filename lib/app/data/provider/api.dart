import 'package:dio/dio.dart';
import 'package:glint/app/data/provider/api_interface.dart';

class FGBPInterceptor extends Interceptor {
  final Dio _dioInstance;
  FGBPInterceptor(this._dioInstance);

  // @override
  // void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
  //   super.onRequest(options, handler);
  // }

  // @override
  // void onError(DioError err, ErrorInterceptorHandler handler) {
  //   super.onError(err, handler);
  // }
}

class FGBPApiProvider implements FGBPApiInterface {
  final Dio dio = Dio();
  final baseUrl = "https://h2o.vg";
  final followRedirects = false;

  FGBPApiProvider() {
    dio.options.baseUrl = baseUrl;
    dio.interceptors.add(FGBPInterceptor(dio));
  }

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
}
