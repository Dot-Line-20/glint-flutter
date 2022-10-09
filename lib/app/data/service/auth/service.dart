import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:glint/app/data/service/auth/repository.dart';
import 'package:glint/app/routes/route.dart';

class AuthService extends GetxService {
  Completer<void>? _refreshTokenApiCompleter;

  final AuthRepository repository;
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  final Rx<String?> _userId = Rx(null);
  final Rx<String?> _accessToken = Rx(null);
  final Rx<String?> _refreshToken = Rx(null);

  /// google sign-in과 onboarding 과정이 완료되었을 경우 true
  bool get isAuthenticated => _accessToken.value != null;

  String? get userId => _userId.value;
  String? get accessToken => _accessToken.value;
  String? get refreshToken => _refreshToken.value;

  AuthService(this.repository);

  Future<AuthService> init() async {
    _userId.value = await _storage.read(key: 'userId');
    _accessToken.value = await _storage.read(key: 'accessToken');
    _refreshToken.value = await _storage.read(key: 'refreshToken');
    return this;
  }

  Future<void> _setUserId(String token) async {
    await _storage.write(key: 'userId', value: token);
    _userId.value = token;
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
      //print(registerResult);
      if (registerResult["status"] == "success") {
        return "회원가입에 성공했습니다. 메일을 확인해주세요.";
      } else {
        return "fail";
      }
    } on DioError {
      rethrow;
    }
  }

  Future<void> login(String email, String password) async {
    try {
      Map loginResult = await repository.login(email, password);
      //print(loginResult);
      _setUserId(loginResult["data"]["id"].toString());
      _setAccessToken(loginResult["data"]["accessToken"]);
      _setRefreshToken(loginResult["data"]["refreshToken"]);
    } on DioError {
      //print(e.response!.statusCode.toString());
      rethrow;
    }
  }

  Future<void> refreshAcessToken() async {
    // refreshTokenApi의 동시 다발적인 호출을 방지하기 위해 completer를 사용함. 동시 다발적으로 이 함수를 호출해도 api는 1번만 호출 됨.
    if (_refreshTokenApiCompleter == null ||
        _refreshTokenApiCompleter!.isCompleted) {
      //첫 호출(null)이거나 이미 완료된 호출(completed completer)일 경우 새 객체 할당
      _refreshTokenApiCompleter = Completer();
      try {
        if (_refreshToken.value == null) {
          //throw RefreshTokenException();
        }
        Map newToken =
            await repository.refreshAccessToken(_refreshToken.value!);

        print(newToken);

        _setAccessToken(newToken["data"]["accessToken"]);
        _setRefreshToken(newToken["data"]["refreshToken"]);
        _refreshTokenApiCompleter!.complete();
      } catch (_) {
        await logout();
        Get.offAllNamed(Routes.login);
        //throw RefreshTokenException();
      }
    }

    return _refreshTokenApiCompleter?.future;
  }

  Future<void> logout() async {
    _userId.value = null;
    _accessToken.value = null;
    _refreshToken.value = null;
    await _storage.delete(key: "userId");
    await _storage.delete(key: 'accessToken');
    await _storage.delete(key: 'refreshToken');
  }
}
