import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glint/app/core/theme/color_theme.dart';
import 'package:glint/app/core/theme/text_theme.dart';
import 'package:glint/app/core/util/constant.dart';
import 'package:glint/app/data/module/user/user.dart';
import 'package:glint/app/data/service/auth/service.dart';
import 'package:glint/app/data/service/chat/chat.dart';
import 'package:glint/app/pages/chat/controller.dart';
import 'package:glint/app/widgets/bottom_sheet.dart';
import 'package:glint/app/widgets/button.dart';
import 'package:glint/app/widgets/empty.dart';
import 'package:glint/app/widgets/textfield.dart';

class ChatPage extends GetView<ChatPageController> {
  const ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          controller.chatRoom.name,
        ),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          children: [
            Expanded(
              child: Obx(
                () => SingleChildScrollView(
                  controller: controller.scrollController,
                  child: _chatMessages(),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: GTTextFormField(
                    controller: controller.messageController,
                    hintText: "입력하세요",
                  ),
                ),
                const SizedBox(width: 16),
                GTIconButton(
                  "assets/images/rabbi.svg",
                  onTap: controller.sendMessage,
                )
              ],
            ),
          ],
        ),
      )),
    );
  }

  Widget _chatMessages() {
    if (controller.messages.value.isEmpty &&
        controller.chatService.messages.value.isEmpty) {
      return const Empty(title: '채팅 없음', description: '채팅을 시작해보세요');
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Obx(
          () => ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: controller.messages.value.length,
            itemBuilder: (context, index) {
              return _chatBubble(controller.messages.value[index]);
            },
          ),
        ),
        Obx(
          () => ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: controller.chatService.messages.value.length,
            itemBuilder: (context, index) {
              return _chatBubble(controller.chatService.messages.value[index]);
            },
          ),
        ),
      ],
    );
  }

  Widget _chatBubble(dynamic message) {
    String content = "";
    User? user;
    if (message is ChatMessage) {
      content = message.content;
      user = message.user;
    } else if (message is Message) {
      content = message.content;
      user = controller.users.value[message.userId];
    }

    bool isMe = user!.id == int.tryParse(Get.find<AuthService>().userId ?? "");

    return GestureDetector(
      onLongPress: () async {
        GTActionType? result =
            await GTBottomSheet([GTActionType.delete, GTActionType.edit])
                .show();
        if (result == GTActionType.delete) {
          controller.deleteMessage(message.id as int, message is ChatMessage);
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!isMe)
              Row(
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(user.profile ?? LOADING),
                      ),
                    ),
                  ),
                  const SizedBox(width: 6),
                ],
              ),
            Expanded(
              child: Column(
                crossAxisAlignment:
                    isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (!isMe)
                    Text(
                      user.name,
                      style: AppTextTheme.T6,
                    ),
                  Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: isMe ? AppColorTheme.Blue : AppColorTheme.Gray5,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 10),
                        child: Text(
                          content,
                          style: isMe
                              ? AppTextTheme.Main.copyWith(color: Colors.white)
                              : AppTextTheme.Main,
                        ),
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
