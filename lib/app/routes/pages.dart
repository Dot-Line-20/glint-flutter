import 'package:glint/app/core/middleware/login.dart';
import 'package:glint/app/pages/comment/binding.dart';
import 'package:glint/app/pages/comment/page.dart';
import 'package:glint/app/pages/home/binding.dart';
import 'package:glint/app/pages/home/page.dart';
import 'package:glint/app/pages/post/binding.dart';
import 'package:glint/app/pages/post/page.dart';
import 'package:glint/app/pages/sns/binding.dart';
import 'package:glint/app/pages/sns/page.dart';
import 'package:glint/app/pages/login/binding.dart';
import 'package:glint/app/pages/login/page.dart';
import 'package:glint/app/pages/register/binding.dart';
import 'package:glint/app/pages/register/view/register_init.dart';
import 'package:glint/app/pages/schedule/binding.dart';
import 'package:glint/app/pages/schedule/page.dart';
import 'package:glint/app/pages/story/binding.dart';
import 'package:glint/app/pages/story/page.dart';
import 'package:glint/app/pages/user/binding.dart';
import 'package:glint/app/pages/user/page.dart';
import 'package:glint/app/routes/route.dart';
import 'package:get/get.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: Routes.home,
      page: () => const HomePage(),
      binding: HomePageBinding(),
      middlewares: [LoginMiddleware()],
    ),
    //user page
    GetPage(
      name: Routes.user,
      page: () => UserPage(),
      binding: UserPageBinding(),
      middlewares: [LoginMiddleware()],
    ),
    GetPage(
      name: Routes.sns,
      page: () => SnsPage(),
      binding: SnsPageBinding(),
      middlewares: [LoginMiddleware()],
    ),
    GetPage(
      name: Routes.post,
      page: () => PostPage(),
      binding: PostPageBinding(),
      middlewares: [LoginMiddleware()],
    ),
    GetPage(
        name: Routes.comment,
        page: () => CommentPage(),
        binding: CommentPageBinding()),
    GetPage(
        name: Routes.story,
        page: () => StoryPage(),
        binding: StoryPageBinding()),
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
