import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glint/app/pages/chat/view/chat.dart';

class ChatRoomListPage extends StatelessWidget {
  const ChatRoomListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Get.to(() => ChatPage());
                  },
                  child: ListTile(
                    title: Text("Title"),
                    subtitle: Text("Subtitle"),
                  ),
                );
              },
            ),
          ),
        ],
      )),
    );
  }
}
