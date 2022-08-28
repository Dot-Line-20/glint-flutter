import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glint/app/core/theme/text_theme.dart';
import 'package:glint/app/pages/register/view/register_check.dart';
import 'package:glint/app/pages/register/view/register_password.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';

class RegisterPageController extends GetxController with StateMixin {
  final TextEditingController nameTextController = TextEditingController();
  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController birthDayController = TextEditingController();
  final TextEditingController idTextController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();
  final TextEditingController passwordCheckTextController =
      TextEditingController();
  final TextEditingController pinController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  final secondFormKey = GlobalKey<FormState>();
  final FocusScopeNode formFocusScopeNode = FocusScopeNode();
  final Rx<DateTime> _selectedDate = DateTime.now().obs;

  final Rx<String?> nameText = Rx(null);
  final Rx<String?> emailText = Rx(null);
  final Rx<String?> birthday = Rx(null);
  final Rx<String?> idText = Rx(null);
  final Rx<String?> passwordText = Rx(null);
  final Rx<String?> passwordCheckText = Rx(null);

  final RegExp isLeast8 = RegExp(r'.{8,}');
  final RegExp isContainSpecial = RegExp(r'(?=.*?[!@#\$&*~])');
  final Rx<String?> guideText = Rx(null);
  final Rx<bool?> _passwordAvailable = Rx(null);

  bool get initInputValidity {
    return nameText.value != null &&
        emailText.value != null &&
        birthday.value != null;
  }

  bool get passwordInputValidity {
    return idText.value != null &&
        passwordText.value != null &&
        passwordCheckText.value != null;
  }

  bool get passwordAvailable {
    return _passwordAvailable.value!;
  }

  bool get passwordAvailableIsNull {
    return _passwordAvailable.value == null;
  }

  @override
  void onInit() {
    change(null, status: RxStatus.success());
    nameTextController.addListener(onNameChange);
    emailTextController.addListener(onEmailChange);
    birthDayController.addListener(onBirthdayChange);
    passwordTextController.addListener(onPasswordChange);
    super.onInit();
  }

  void onNameChange() {
    String data = nameTextController.text;
    nameText.value = data.isEmpty ? null : data;
  }

  void onEmailChange() {
    String data = emailTextController.text;
    emailText.value = data.isEmpty ? null : data;
  }

  void onBirthdayChange() {
    String data = birthDayController.text;
    birthday.value = data.isEmpty ? null : data;
  }

  void onPasswordChange() {
    String data = passwordTextController.text;

    if (isLeast8.hasMatch(data) && isContainSpecial.hasMatch(data)) {
      guideText.value = "사용 가능한 비밀번호입니다";
      _passwordAvailable.value = true;
    } else {
      guideText.value = "사용 불가능한 비밀번호입니다";
      _passwordAvailable.value = false;
    }
  }

  void moveToSecondPage() {
    Get.to(() => const RegisterPasswordPage());
  }

  void moveToThirdPage() {
    Get.to(() => const RegisterCheckPage());
  }

  void pickDateTime() async {
    // DateTime? result = await showDatePicker(
    //     context: Get.context!,
    //     initialEntryMode: DatePickerEntryMode.inputOnly,
    //     initialDate: DateTime.now(),
    //     firstDate: DateTime(1900),
    //     lastDate: DateTime.now());

    Get.dialog(
      Dialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "생일 설정",
                style: AppTextTheme.boldGray1_20,
                textAlign: TextAlign.start,
              ),
              const SizedBox(height: 15),
              SizedBox(
                width: 250,
                height: 45,
                child: ScrollDatePicker(
                  selectedDate: _selectedDate.value,
                  minimumDate: DateTime(1900),
                  maximumDate: DateTime(2100),
                  locale: const Locale('ko'),
                  scrollViewOptions: const DatePickerScrollViewOptions(
                      year: ScrollViewDetailOptions(
                        label: '년',
                        margin: EdgeInsets.only(right: 16),
                        textStyle: AppTextTheme.boldGray2_20,
                        selectedTextStyle: AppTextTheme.boldGray2_20,
                      ),
                      month: ScrollViewDetailOptions(
                        label: '월',
                        margin: EdgeInsets.only(right: 16),
                        textStyle: AppTextTheme.boldGray2_20,
                        selectedTextStyle: AppTextTheme.boldGray2_20,
                      ),
                      day: ScrollViewDetailOptions(
                        label: '일',
                        textStyle: AppTextTheme.boldGray2_20,
                        selectedTextStyle: AppTextTheme.boldGray2_20,
                      )),
                  onDateTimeChanged: (DateTime value) {
                    birthDayController.text = value.convertStringFormat;
                    _selectedDate.value = value;
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

extension DateTimeToString on DateTime {
  String get convertStringFormat => "$year년 $month월 $day일";
}
