import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:glint/app/data/service/auth/repository.dart';

class AuthService extends GetxService {
  final AuthRepository repository;
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  final Rx<String?> _accessToken = Rx(null);
  final Rx<String?> _refreshToken = Rx(null);

  /// google sign-in과 onboarding 과정이 완료되었을 경우 true
  bool get isAuthenticated => _accessToken.value != null;

  String? get accessToken => _accessToken.value;
  String? get refreshToken => _refreshToken.value;

  AuthService(this.repository);

  Future<AuthService> init() async {
    _accessToken.value = await _storage.read(key: 'accessToken');
    _refreshToken.value = await _storage.read(key: 'refreshToken');
    return this;
  }

  Future<void> _setAccessToken(String token) async {
    await _storage.write(key: 'accessToken', value: token);
    _accessToken.value = token;
  }

  Future<void> _setRefreshToken(String token) async {
    await _storage.write(key: 'refreshToken', value: token);
    _refreshToken.value = token;
  }

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
        _setAccessToken(loginResult["data"]["accessToken"]);
        _setRefreshToken(loginResult["data"]["refreshToken"]);
      }
    } on DioError catch (e) {
      print(e.response!.statusCode.toString());
      rethrow;
    }
  }

  Future<void> refreshAcessToken() async {}

  Future<void> logout() async {
    _accessToken.value = null;
    _refreshToken.value = null;
    await _storage.delete(key: 'accessToken');
    await _storage.delete(key: 'refreshToken');
  }
}
