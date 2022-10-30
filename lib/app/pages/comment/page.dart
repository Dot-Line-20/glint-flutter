import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glint/app/core/theme/color_theme.dart';
import 'package:glint/app/core/theme/text_theme.dart';
import 'package:glint/app/data/models/comment.dart';
import 'package:glint/app/data/models/user.dart';
import 'package:glint/app/data/module/user/service.dart';
import 'package:glint/app/pages/comment/controller.dart';
import 'package:glint/app/pages/comment/widget/bottomsheet.dart';
import 'package:glint/app/widgets/button.dart';
import 'package:glint/app/widgets/textfield.dart';

class CommentPage extends GetView<CommentPageController> {
  CommentPage({Key? key}) : super(key: key);

  final UserController userController = Get.find<UserController>();

  Widget header() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        GTIconButton("assets/images/left_arrow.svg", onTap: () {
          Get.back();
        }),
        const SizedBox(width: 20),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: AppColorTheme.BUTTON1,
          ),
          height: 44,
          width: 44,
        ),
        const SizedBox(width: 16),
        const Text("sdjafhjgfsh", style: AppTextTheme.boldGray1_18),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              header(),
              const SizedBox(height: 16),
              controller.obx(
                (_) => Expanded(
                  child: Obx(
                    () => ListView.builder(
                      shrinkWrap: true,
                      itemCount: controller.commentList.length,
                      itemBuilder: (context, index) {
                        return item(controller.commentList[index]);
                      },
                    ),
                  ),
                ),
                onLoading: const Expanded(
                  child: Center(
                    child: CircularProgressIndicator(color: AppColorTheme.Blue),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: GTTextFormField(
                      controller: controller.commentTextController,
                      hintText: "입력하세요",
                    ),
                  ),
                  const SizedBox(width: 16),
                  GTIconButton(
                    "assets/images/rabbi.svg",
                    onTap: controller.addComment,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget item(Comment comment) {
    User? user = userController.getUser(comment.userId);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey,
                    ),
                    child: Image.network("src"),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user?.name ?? "",
                        style: AppTextTheme.semiboldGrey1_14,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        user?.email ?? "",
                        style: AppTextTheme.lightGray3_14,
                      ),
                    ],
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  CommentBottomSheet().bottomSheet();
                },
                child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColorTheme.Gray4,
                    ),
                    width: 32,
                    height: 32,
                    child: const Icon(Icons.more_horiz)),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            comment.content,
            style: AppTextTheme.regularGrey1_14,
          ),
        ],
      ),
    );
  }
}
