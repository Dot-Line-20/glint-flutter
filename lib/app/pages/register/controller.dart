import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class RegisterPageController extends GetxController with StateMixin {
  final TextEditingController idTextController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  final FocusScopeNode formFocusScopeNode = FocusScopeNode();

  final Rx<String?> idText = Rx(null);
  final Rx<String?> passwordText = Rx(null);

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
    print(idText.value);
  }

  void onPasswordChange() {
    String data = passwordTextController.text;
    passwordText.value = data.isEmpty ? null : data;
  }
}
