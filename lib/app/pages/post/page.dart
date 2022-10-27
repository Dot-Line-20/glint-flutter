import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:glint/app/pages/post/controller.dart';
import 'package:glint/app/widgets/button.dart';
import 'package:glint/app/widgets/textfield.dart';

class PostPage extends GetView<PostPageController> {
  const PostPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("새 게시물"),
          actions: [
            TextButton(
              onPressed: () {
                //controller.createPost();
              },
              child: const Text(
                "공유하기",
              ),
            )
          ],
        ),
        body: SafeArea(
          child: Column(
            children: [
              const GTTextFormField(
                maxLength: 5,
                hintText: "내용을 적어주세요",
              ),
              GTMediumTextButton(
                  text: "사진/동영상", onTap: controller.getFileFromPicker),
            ],
          ),
        ));
  }
}
