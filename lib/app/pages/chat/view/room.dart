import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glint/app/core/theme/text_theme.dart';
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
          style: AppTextTheme.boldGray1_18,
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
                  return GestureDetector(
                    onTap: () => controller
                        .enterChatRoom(controller.chatRooms.value[index].id),
                    child: Row(
                      children: [
                        const SizedBox(width: 20),
                        const CircleAvatar(
                          radius: 20,
                        ),
                        const SizedBox(width: 20),
                        Text(controller.chatRooms.value[index].name),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      )),
    );
  }
}
