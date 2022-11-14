import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glint/app/data/module/user/user.dart';
import 'package:glint/app/data/service/chat/chat.dart';
import 'package:glint/app/data/service/chat/service.dart';

class ChatPageController extends GetxController {
  final ChatService chatService = Get.find<ChatService>();
  final TextEditingController messageController = TextEditingController();

  final ChatRoom chatRoom = Get.arguments;

  Rx<List<ChatMessage>> messages = Rx([]);
  Rx<Map<int, User>> users = Rx({});

  @override
  void onInit() async {
    // Get the chat rooms
    await enterChatRoom(chatRoom.users, chatRoom.id);
    // scroll to bottom
    super.onInit();
  }

  @override
  void onClose() {
    chatService.leaveChatRoom();
    super.onClose();
  }

  Future enterChatRoom(List<Users> userIds, int chatRoomId) async {
    for (Users user in userIds) {
      if (!users.value.containsKey(user.user.id)) {
        users.value[user.user.id] = user.user;
      }
    }
    messages.value = await chatService.getChatMessages(chatRoomId);

    chatService.enterChatRoom(chatRoomId);

    // scroll to bottom after delay
    Future.delayed(Duration(milliseconds: 10), () {
      scrollController.jumpTo(scrollController.position.maxScrollExtent);
    });

    //scrollController.jumpTo(scrollController.position.maxScrollExtent);

    //await Get.to(() => ChatPage(chatRoomName: chatRoomName));
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

  final int _limit = 2;
  final Rx<int> _page = 0.obs;
  final Rx<bool> _isFirstLoadRunning = false.obs;
  final Rx<bool> _isLoadMoreRunning = false.obs;
  final ScrollController scrollController = ScrollController();

  bool get isLoading => _isFirstLoadRunning.value || _isLoadMoreRunning.value;

  _loadMore(int chatRoomId) {
    if (_isFirstLoadRunning.value == false &&
        _isLoadMoreRunning.value == false &&
        scrollController.position.extentAfter < 300) {
      _isLoadMoreRunning.value =
          true; // Display a progress indicator at the bottom
      _page.value += 1; // Increase _page by 1
      chatService.getChatMessages(chatRoomId, index: _page.value, size: _limit);
      _isLoadMoreRunning.value = false;
    }
  }
}
