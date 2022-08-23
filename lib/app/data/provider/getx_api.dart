import 'dart:async';

import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';

class FGBPRequestInterceptor {
  FutureOr<Request> onRequest(Request request) async {
    request.headers["apiKey"] = "1235446";
    return request;
  }

  FutureOr<Request> auth(Request request) async {
    request.headers["apiKey"] = "1235446";
    return request;
  }
}

class FGBPResponseInterceptor {
  FutureOr<Request> onResponse(Request request, Response response) async {
    request.headers["apiKey"] = "1235446";
    return request;
  }
}

class FGBPApiProvider extends GetConnect {
  @override
  void onInit() {
    //httpClient.defaultDecoder
    httpClient.baseUrl = "http";
    httpClient.addRequestModifier(FGBPRequestInterceptor().onRequest);
    httpClient.addResponseModifier(FGBPResponseInterceptor().onResponse);
    httpClient.addAuthenticator(FGBPRequestInterceptor().onRequest);
  }
}
