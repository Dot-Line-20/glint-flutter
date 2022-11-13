import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glint/app/core/theme/color_theme.dart';
import 'package:glint/app/core/theme/text_theme.dart';
import 'package:glint/app/core/util/constant.dart';
import 'package:glint/app/data/module/comment/comment.dart';
import 'package:glint/app/data/module/comment/controller.dart';
import 'package:glint/app/data/module/user/user.dart';
import 'package:glint/app/data/module/user/controller.dart';
import 'package:glint/app/pages/comment/controller.dart';
import 'package:glint/app/pages/comment/widget/bottomsheet.dart';
import 'package:glint/app/widgets/bottom_sheet.dart';
import 'package:glint/app/widgets/button.dart';
import 'package:glint/app/widgets/constant.dart';
import 'package:glint/app/widgets/empty.dart';
import 'package:glint/app/widgets/textfield.dart';

class CommentPage extends GetView<CommentPageController> {
  const CommentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "댓글",
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
          child: Column(
            children: [
              Expanded(
                child: _commentItem(),
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

  Widget _commentItem() {
    return controller.obx((_) {
      if (controller.commentList.isEmpty) {
        return Wrap(
          children: const [
            Empty(title: "댓글 없음", description: "첫 댓글을 작성해주세요!"),
          ],
        );
      }

      return Obx(
        () => ListView.builder(
          shrinkWrap: true,
          itemCount: controller.commentList.length,
          itemBuilder: (context, index) {
            return CommentItem(comment: controller.commentList[index]);
          },
        ),
      );
    }, onLoading: LOADINGINDICATOR);
  }
}

class CommentItem extends StatelessWidget {
  final Comment comment;

  const CommentItem({Key? key, required this.comment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User>(
        future: UserController.to.getOtherUserInfo(comment.userId),
        builder: (context, snapshot) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (snapshot.hasData) _commentHeader(snapshot.data),
                    _commentAction(),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  comment.content,
                  style: AppTextTheme.Main,
                ),
              ],
            ),
          );
        });
  }

  Row _commentHeader(user) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey,
            image: DecorationImage(
              image: NetworkImage(user.profile ?? LOADING),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              user.name,
              style: AppTextTheme.T6,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
            const SizedBox(height: 4),
            Text(user.email,
                style: AppTextTheme.Main.copyWith(color: AppColorTheme.Gray3)),
          ],
        ),
      ],
    );
  }

  Widget _commentAction() {
    return GestureDetector(
      onTap: () async {
        GTActionType? result =
            await GTBottomSheet([GTActionType.delete]).show();
        if (result == GTActionType.delete) {
          CommentController.to.deleteComment(comment.postId, comment.id);
        }
      },
      child: Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColorTheme.Gray4,
          ),
          width: 32,
          height: 32,
          child: const Icon(Icons.more_horiz)),
    );
  }
}
