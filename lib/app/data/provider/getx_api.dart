import 'dart:async';

import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';

class GTRequestInterceptor {
  FutureOr<Request> onRequest(Request request) async {
    request.headers["apiKey"] = "1235446";
    return request;
  }

  FutureOr<Request> auth(Request request) async {
    request.headers["apiKey"] = "1235446";
    return request;
  }
}

class GTResponseInterceptor {
  FutureOr<Request> onResponse(Request request, Response response) async {
    request.headers["apiKey"] = "1235446";
    return request;
  }
}

class GTApiProvider extends GetConnect {
  @override
  void onInit() {
    //httpClient.defaultDecoder
    httpClient.baseUrl = "http";
    httpClient.addRequestModifier(GTRequestInterceptor().onRequest);
    httpClient.addResponseModifier(GTResponseInterceptor().onResponse);
    httpClient.addAuthenticator(GTRequestInterceptor().onRequest);
  }
}
