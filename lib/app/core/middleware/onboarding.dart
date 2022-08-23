import 'package:glint/app/routes/route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingMiddleware extends GetMiddleware {
  //final AuthService authService = Get.find<AuthService>();

  OnboardingMiddleware({super.priority});

  @override
  RouteSettings? redirect(String? route) {
    return false
        ? null
        : RouteSettings(name: Routes.home, arguments: {
            'redirect': route,
          });
  }

  @override
  GetPage? onPageCalled(GetPage? page) {
    return super.onPageCalled(page);
  }

  @override
  List<Bindings>? onBindingsStart(List<Bindings>? bindings) {
    // TODO: implement onBindingsStart
    return super.onBindingsStart(bindings);
  }

  @override
  GetPageBuilder? onPageBuildStart(GetPageBuilder? page) {
    // TODO: implement onPageBuildStart
    return super.onPageBuildStart(page);
  }

  @override
  Widget onPageBuilt(Widget page) {
    // TODO: implement onPageBuilt
    return super.onPageBuilt(page);
  }

  @override
  void onPageDispose() {
    // TODO: implement onPageDispose
    super.onPageDispose();
  }
}
