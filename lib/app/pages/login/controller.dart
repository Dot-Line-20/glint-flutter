import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:glint/app/data/service/auth/service.dart';
import 'package:glint/app/routes/route.dart';
import 'package:glint/app/widgets/snackbar.dart';

class LoginPageController extends GetxController with StateMixin {
  final String? redirect = Get.arguments?['redirect'];

  final TextEditingController idTextController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  final FocusScopeNode formFocusScopeNode = FocusScopeNode();

  final Rx<String?> idText = Rx(null);
  final Rx<String?> passwordText = Rx(null);

  final AuthService authService = Get.find<AuthService>();

  bool get inputValidity {
    return idText.value != null && passwordText.value != null;
  }

  @override
  void onInit() {
    change(null, status: RxStatus.success());
    idTextController.addListener(onIdChange);
    passwordTextController.addListener(onPasswordChange);
    super.onInit();
  }

  void onIdChange() {
    String data = idTextController.text;
    idText.value = data.isEmpty ? null : data;
    //print(idText.value);
  }

  void onPasswordChange() {
    String data = passwordTextController.text;
    passwordText.value = data.isEmpty ? null : data;
  }

  void moveToRegisterPage() {
    Get.toNamed(Routes.register);
  }

  void moveToSchedulePage() {
    Get.toNamed(Routes.schedule);
  }

  void login() async {
    change(null, status: RxStatus.loading());
    try {
      await authService.login(idText.value!, passwordText.value!);
      await Future.delayed(const Duration(seconds: 2));
      if (authService.isAuthenticated) {
        final String nextRoute = redirect ?? Routes.home;
        Get.offNamed(nextRoute);
      }
    } on DioError catch (e) {
      print(e.response!.data);
      GTSnackBar.open(e.response!.data["data"][0]["title"]);
    } finally {
      change(null, status: RxStatus.success());
    }
  }
}
