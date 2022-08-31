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
  final baseUrl = "https:...";

  FGBPApiProvider() {
    dio.options.baseUrl = baseUrl;
    dio.interceptors.add(FGBPInterceptor(dio));
  }

  @override
  Future<void> getInfo() async {
    String url = "/test";
    dio.post(url);
  }
}
