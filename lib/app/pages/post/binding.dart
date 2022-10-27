import 'package:get/get.dart';
import 'package:glint/app/pages/post/controller.dart';

class PostPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PostPageController>(() => PostPageController());
  
  }
}
