import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingMiddleware extends GetMiddleware {
  //final AuthService authService = Get.find<AuthService>();

  OnboardingMiddleware({super.priority});

  @override
  RouteSettings? redirect(String? route) {
    return null;
    // return authService.isAuthenticated
    //     ? null
    //     : RouteSettings(name: Routes.PIN, arguments: {
    //         'redirect': route,
    //         'pinPageType': PinPageType.onBoarding
    //       });
  }
}
