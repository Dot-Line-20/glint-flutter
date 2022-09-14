import 'dart:async';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:glint/app/data/service/auth/repository.dart';

class AuthService extends GetxService {
  final AuthRepository repository;
  final Rx<String?> _accessToken = Rx(null);
  final Rx<String?> _refreshToken = Rx(null);

  /// google sign-in과 onboarding 과정이 완료되었을 경우 true
  bool get isAuthenticated => _accessToken.value != null;

  String? get accessToken => _accessToken.value;
  String? get refreshToken => _refreshToken.value;

  AuthService(this.repository);

  Future<String> registerUser(
      String email, String password, String name, String birth) async {
    try {
      Map registerResult =
          await repository.registerUser(email, password, name, birth);
      print(registerResult);
      if (registerResult["status"] == "success") {
        return "회원가입에 성공했습니다. 메일을 확인해주세요.";
      } else {
        return "fail";
      }
    } on DioError catch (e) {
      rethrow;
    }
  }

  Future<void> login(String email, String password) async {
    try {
      Map loginResult = await repository.login(email, password);
      print(loginResult);
      if (loginResult["status"] == "success") {
        _accessToken.value = loginResult["data"]["accessToken"];
        _refreshToken.value = loginResult["data"]["refreshToken"];
      }
    } on DioError catch (e) {
      print(e.response!.statusCode.toString());
      rethrow;
    }
  }
}
