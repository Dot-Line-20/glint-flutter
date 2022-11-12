import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:glint/app/data/models/chat.dart';
import 'package:glint/app/data/service/auth/service.dart';
import 'package:glint/app/data/service/chat/service.dart';
import 'package:glint/app/pages/chat/view/chat.dart';

class ChatController extends GetxController with StateMixin<List<ChatRoom>> {
  final AuthService authService = Get.find<AuthService>();
  final ChatService chatService = Get.find<ChatService>();

  final TextEditingController messageController = TextEditingController();

  Rx<List<ChatRoom>> chatRooms = Rx([]);
  Rx<List<ChatMessage>> messages = Rx([]);

  @override
  void onInit() async {
    super.onInit();
    change(null, status: RxStatus.loading());

    chatService.io.connect();

    chatService.authLogin(authService.accessToken!);
    chatRooms.value = await chatService.getChatRooms();
    change(null, status: RxStatus.success());
  }

  enterChatRoom(int chatRoomId) async {
    messages.value = await chatService.getChatMessages(chatRoomId);
    chatService.enterChatRoom(chatRoomId);
    Get.to(() => ChatPage());
  }

  void sendMessage() async {
    if (messageController.text.isEmpty) {
      return;
    }
    chatService.sendMessage(messageController.text);
    messageController.clear();
  }
}
