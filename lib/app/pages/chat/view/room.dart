import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glint/app/core/theme/text_theme.dart';
import 'package:glint/app/core/util/constant.dart';
import 'package:glint/app/data/service/chat/chat.dart';
import 'package:glint/app/pages/chat/controller.dart';
import 'package:glint/app/widgets/constant.dart';
import 'package:glint/app/widgets/empty.dart';

class ChatRoomListPage extends GetView<ChatController> {
  const ChatRoomListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "채팅",
        ),
      ),
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
            child: controller.obx((_) => _chatRoomItems(),
                onLoading: LOADINGINDICATOR),
          ),
        ],
      )),
    );
  }

  Widget _chatRoomItems() {
    if (controller.chatRooms.value.isEmpty) {
      return const Empty(title: "채팅 없음", description: "다른 사람과 채팅을 시작해보세요");
    }

    return ListView.builder(
      itemCount: controller.chatRooms.value.length,
      itemBuilder: (context, index) {
        return _chatRoomItem(controller.chatRooms.value[index]);
      },
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
