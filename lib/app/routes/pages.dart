import 'package:glint/app/core/middleware/login.dart';
import 'package:glint/app/pages/category/binding.dart';
import 'package:glint/app/pages/category/page.dart';
import 'package:glint/app/pages/chat/binding.dart';
import 'package:glint/app/pages/chat/view/chat.dart';
import 'package:glint/app/pages/chat/view/room.dart';
import 'package:glint/app/pages/comment/binding.dart';
import 'package:glint/app/pages/comment/page.dart';
import 'package:glint/app/pages/home/binding.dart';
import 'package:glint/app/pages/home/page.dart';
import 'package:glint/app/pages/post/binding.dart';
import 'package:glint/app/pages/post/page.dart';
import 'package:glint/app/pages/feed/binding.dart';
import 'package:glint/app/pages/feed/page.dart';
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
      page: () => HomePage(),
      binding: HomePageBinding(),
      middlewares: [LoginMiddleware()],
    ),
    GetPage(
      name: Routes.chat,
      page: () => ChatRoomListPage(),
      middlewares: [LoginMiddleware()],
    ),
    GetPage(
      name: Routes.chatRoom,
      page: () => ChatPage(),
      binding: ChatBinding(),
      middlewares: [LoginMiddleware()],
    ),
    //user page
    GetPage(
      name: Routes.user,
      page: () => UserProfilePage(),
      binding: UserPageBinding(),
      middlewares: [LoginMiddleware()],
    ),
    GetPage(
      name: Routes.feed,
      page: () => FeedPage(),
      binding: FeedPageBinding(),
      middlewares: [LoginMiddleware()],
    ),
    GetPage(
      name: Routes.post,
      page: () => const PostPage(),
      binding: PostPageBinding(),
      middlewares: [LoginMiddleware()],
    ),
    GetPage(
      name: Routes.category,
      page: () => CategoryPage(),
      binding: CategoryPageBinding(),
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
      page: () => SchedulePage(),
      binding: SchedulePageBinding(),
      middlewares: [LoginMiddleware()],
    ),
  ];
}
