import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:glint/app/data/module/user/controller.dart';
import 'package:glint/app/data/module/user/user.dart';
import 'package:glint/app/data/service/chat/chat.dart';
import 'package:glint/app/data/service/auth/service.dart';
import 'package:glint/app/data/service/chat/service.dart';
import 'package:glint/app/pages/chat/view/chat.dart';

class ChatController extends GetxController with StateMixin<List<ChatRoom>> {
  final AuthService authService = Get.find<AuthService>();
  final ChatService chatService = Get.find<ChatService>();
  final UserController userController = Get.find<UserController>();

  final TextEditingController messageController = TextEditingController();

  Rx<List<ChatRoom>> chatRooms = Rx([]);
  Rx<List<ChatMessage>> messages = Rx([]);
  Rx<Map<int, User>> users = Rx({});

  @override
  void onInit() async {
    super.onInit();
    change(null, status: RxStatus.loading());
    chatService.authLogin(authService.accessToken!);
    chatRooms.value = await chatService.getChatRooms();
    change(null, status: RxStatus.success());
  }

  void enterChatRoom(
      List<Users> userIds, int chatRoomId, String chatRoomName) async {
    for (Users user in userIds) {
      if (!users.value.containsKey(user.user.id)) {
        users.value[user.user.id] = user.user;
      }
    }
    messages.value = await chatService.getChatMessages(chatRoomId);
    chatService.enterChatRoom(chatRoomId);
    await Get.to(() => ChatPage(chatRoomName: chatRoomName));
    chatService.leaveChatRoom();
  }

  void sendMessage() async {
    if (messageController.text.isEmpty) {
      return;
    }
    chatService.sendMessage(messageController.text);
    messageController.clear();
  }

  void deleteMessage(int messageId, messageType) {
    chatService.deleteMessage(messageId);

    if (messageType) {
      messages.value
          .removeWhere((ChatMessage message) => message.id == messageId);
      messages.refresh();
    } else {
      chatService.messages.value
          .removeWhere((Message message) => message.id == messageId);
      chatService.messages.refresh();
    }
  }
}
