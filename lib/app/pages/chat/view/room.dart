import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glint/app/core/theme/text_theme.dart';
import 'package:glint/app/core/util/constant.dart';
import 'package:glint/app/data/service/chat/chat.dart';
import 'package:glint/app/pages/chat/controller.dart';

class ChatRoomListPage extends GetView<ChatController> {
  const ChatRoomListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "채팅",
          style: AppTextTheme.T4,
        ),
      ),
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
            child: controller.obx(
              (_) => ListView.builder(
                itemCount: controller.chatRooms.value.length,
                itemBuilder: (context, index) {
                  return _chatRoomItem(controller.chatRooms.value[index]);
                },
              ),
            ),
          ),
        ],
      )),
    );
  }

  Widget _chatRoomItem(ChatRoom chatRoom) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: GestureDetector(
        onTap: () {
          controller.enterChatRoom(chatRoom.users, chatRoom.id);
        },
        child: Row(
          children: [
            const SizedBox(width: 20),
            CircleAvatar(
              radius: 20,
              backgroundImage:
                  NetworkImage(chatRoom.users.first.user.profile ?? LOADING),
            ),
            const SizedBox(width: 20),
            Text(chatRoom.name, style: AppTextTheme.T3),
          ],
        ),
      ),
    );
  }
}
