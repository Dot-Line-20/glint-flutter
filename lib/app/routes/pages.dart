import 'package:glint/app/pages/home/binding.dart';
import 'package:glint/app/pages/home/page.dart';
import 'package:glint/app/pages/login/binding.dart';
import 'package:glint/app/pages/login/page.dart';
import 'package:glint/app/pages/register/binding.dart';
import 'package:glint/app/pages/register/page.dart';
import 'package:glint/app/routes/route.dart';
import 'package:get/get.dart';

class AppPages {
  static final pages = [
    GetPage(
        name: Routes.home,
        page: () => const HomePage(),
        binding: HomePageBinding()),
    GetPage(
        name: Routes.login,
        page: () => const LoginPage(),
        binding: LoginPageBinding()),
    GetPage(
        name: Routes.register,
        page: () => const RegisterPage(),
        binding: RegisterPageBinding()),
  ];
}
