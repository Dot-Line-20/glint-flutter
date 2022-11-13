import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glint/app/core/theme/color_theme.dart';
import 'package:glint/app/core/theme/text_theme.dart';

import 'package:glint/app/pages/post/controller.dart';
import 'package:glint/app/widgets/button.dart';
import 'package:glint/app/widgets/constant.dart';
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
            style: AppTextTheme.T4,
          ),
          actions: [
            TextButton(
              onPressed: controller.createPost,
              child: const Text(
                "공유하기",
                style: AppTextTheme.Main,
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
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GTTextFormField(
                      controller: controller.contentController,
                      maxLines: 5,
                      hintText: "내용을 적어주세요",
                    ),
                    const SizedBox(height: 8),
                    // horizonatal scrollable
                    Row(
                      children: [
                        Expanded(
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(
                              minHeight: 25,
                              maxHeight: 30,
                            ),
                            child: Obx(
                              () => ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: controller.categories.value.length,
                                itemBuilder: (context, index) {
                                  // radius random color
                                  return Container(
                                    margin: const EdgeInsets.only(right: 8),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      color: AppColorTheme.BUTTON1,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 4),
                                      child: Text(
                                        controller.categories.value[index].name,
                                        style: AppTextTheme.T6.copyWith(
                                            color: AppColorTheme.white),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                        // add iconbutton
                        GTIconButton(
                          "assets/images/rabbi.svg",
                          onTap: controller.getCategory,
                        ),
                      ],
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
                                  child: LOADINGINDICATOR),
                            ),
                            Center(
                                child: Text(
                              "${controller.progress}%",
                              style: AppTextTheme.T6,
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
      if (GetPlatform.isWeb) {
        return Image.memory(
          controller.fileBytes(index),
          fit: BoxFit.cover,
        );
      }
      return Image.file(
        File(controller.filePath(index)),
        fit: BoxFit.cover,
      );
    }

    if (GetPlatform.isWeb) {
      return const Center(
        child: Text(
          "동영상 미리보기는 웹에서 지원하지 않습니다.",
          style: AppTextTheme.T6,
        ),
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
