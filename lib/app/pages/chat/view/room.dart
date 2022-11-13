import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glint/app/core/theme/color_theme.dart';
import 'package:glint/app/core/theme/text_theme.dart';
import 'package:glint/app/core/util/constant.dart';
import 'package:glint/app/data/service/chat/chat.dart';
import 'package:glint/app/pages/chat/controller.dart';
import 'package:glint/app/widgets/bottom_sheet.dart';
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              controller.enterChatRoom(
                  chatRoom.users, chatRoom.id, chatRoom.name);
            },
            child: Row(
              children: [
                const SizedBox(width: 10),
                ChatRoomProfile(users: chatRoom.users),
                const SizedBox(width: 10),
                Text("${chatRoom.name} (${chatRoom.users.length})",
                    style: AppTextTheme.Main.copyWith(fontSize: 16)),
              ],
            ),
          ),

          //button with setting icon
          IconButton(
            icon: const Icon(Icons.more_horiz_sharp),
            onPressed: () async {
              GTActionType? result = await GTBottomSheet([
                GTActionType.delete,
              ]).show();
              if (result == GTActionType.delete) {
                //controller.deleteChatRoom(chatRoom.id);
              }
            },
          ),
        ],
      ),
    );
  }
}

class ChatRoomProfile extends StatelessWidget {
  const ChatRoomProfile({Key? key, required this.users}) : super(key: key);

  final List<Users> users;

  // random double 0 ~ 24
  double getRandomInt() {
    return (Random().nextDouble() * 24).roundToDouble();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), color: AppColorTheme.Gray3),
      child: Stack(
        children: [
          for (int i = 0; i < users.length; i++)
            _userProfileItem(getRandomInt(), getRandomInt(), i)
        ],
      ),
    );
  }

  Positioned _userProfileItem(left, top, index) {
    return Positioned(
      left: left,
      top: top,
      child: Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          image: DecorationImage(
            image: NetworkImage(users[index].user.profile ?? LOADING),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
