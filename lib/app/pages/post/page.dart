import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glint/app/core/theme/color_theme.dart';
import 'package:glint/app/core/theme/text_theme.dart';

import 'package:glint/app/pages/post/controller.dart';
import 'package:glint/app/widgets/button.dart';
import 'package:glint/app/widgets/textfield.dart';

class PostPage extends GetView<PostPageController> {
  const PostPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: const Text(
            "새 게시물",
            style: AppTextTheme.boldGray1_18,
          ),
          actions: [
            TextButton(
              onPressed: controller.createPost,
              child: const Text(
                "공유하기",
                style: AppTextTheme.boldGray2_14,
              ),
            )
          ],
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Column(
                  children: [
                    GTTextFormField(
                      controller: controller.contentController,
                      maxLength: 5,
                      maxLines: 5,
                      hintText: "내용을 적어주세요",
                    ),
                    const SizedBox(height: 16),
                    Obx(
                      () => Expanded(
                        child: GridView.count(
                          shrinkWrap: true,
                          crossAxisCount: 3,
                          children:
                              List.generate(controller.fileCount, (index) {
                            return pickedFile(index);
                          }),
                        ),
                      ),
                    ),
                    GTMediumTextButton(
                        text: "사진/동영상", onTap: controller.getFileFromPicker),
                  ],
                ),
                Obx(() => controller.isUploading.isTrue
                    ? Center(
                        child: Stack(
                          children: <Widget>[
                            const Center(
                              child: SizedBox(
                                width: 100,
                                height: 100,
                                child: CircularProgressIndicator(
                                  strokeWidth: 5,
                                  color: AppColorTheme.Blue,
                                ),
                              ),
                            ),
                            Center(
                                child: Text(
                              "${controller.progress}%",
                              style: AppTextTheme.boldGray2_14,
                            )),
                          ],
                        ),
                      )
                    : Container())
              ],
            ),
          ),
        ));
  }

  Widget pickedFile(int index) {
    if (controller.filePickerResult.value?.files[index].extension != "mp4") {
      return Image.file(
        File(controller.filePath(index)),
        fit: BoxFit.cover,
      );
    }

    return FutureBuilder<Uint8List?>(
      future: controller.videoThumbnail(index),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Stack(
            children: [
              Image.memory(
                snapshot.data!,
                fit: BoxFit.cover,
              ),
            ],
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
