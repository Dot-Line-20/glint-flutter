import 'package:get/get.dart';
import 'package:glint/app/pages/chat/controller.dart';

class ChatBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChatController>(() => ChatController());
  }
}
