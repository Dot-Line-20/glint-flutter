import 'package:glint/app/pages/home/binding.dart';
import 'package:glint/app/pages/home/page.dart';
import 'package:glint/app/routes/route.dart';
import 'package:get/get.dart';

class AppPages {
  static final pages = [
    GetPage(
        name: Routes.home,
        page: () => const HomePage(),
        binding: HomePageBinding()),
  ];
}
