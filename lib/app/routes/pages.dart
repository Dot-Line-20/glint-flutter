import 'package:glint/app/core/middleware/login.dart';
import 'package:glint/app/pages/sns/binding.dart';
import 'package:glint/app/pages/sns/page.dart';
import 'package:glint/app/pages/login/binding.dart';
import 'package:glint/app/pages/login/page.dart';
import 'package:glint/app/pages/register/binding.dart';
import 'package:glint/app/pages/register/view/register_init.dart';
import 'package:glint/app/pages/schedule/binding.dart';
import 'package:glint/app/pages/schedule/page.dart';
import 'package:glint/app/routes/route.dart';
import 'package:get/get.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: Routes.home,
      page: () => const SnsPage(),
      binding: SnsPageBinding(),
      middlewares: [LoginMiddleware()],
    ),
    GetPage(
      name: Routes.sns,
      page: () => const SnsPage(),
      binding: SnsPageBinding(),
      middlewares: [LoginMiddleware()],
    ),
    GetPage(
        name: Routes.login,
        page: () => const LoginPage(),
        binding: LoginPageBinding()),
    GetPage(
        name: Routes.register,
        page: () => const RegisterInitPage(),
        binding: RegisterPageBinding()),
    GetPage(
      name: Routes.schedule,
      page: () => const SchedulePage(),
      binding: SchedulePageBinding(),
      middlewares: [LoginMiddleware()],
    ),
  ];
}
