import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glint/app/data/service/auth/service.dart';
import 'package:glint/app/routes/route.dart';

class LoginMiddleware extends GetMiddleware {
  final AuthService authService = Get.find<AuthService>();

  LoginMiddleware({super.priority});

  @override
  RouteSettings? redirect(String? route) {
    return authService.isAuthenticated
        ? null
        : RouteSettings(name: Routes.login, arguments: {'redirect': route});
  }
}
