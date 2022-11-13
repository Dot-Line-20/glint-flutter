import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glint/app/core/theme/color_theme.dart';
import 'package:glint/app/core/theme/text_theme.dart';
import 'package:glint/app/pages/feed/controller.dart';
import 'package:glint/app/pages/feed/widget/feed.dart';
import 'package:glint/app/routes/route.dart';
import 'package:glint/app/widgets/button.dart';
import 'package:glint/app/widgets/constant.dart';
import 'package:glint/app/widgets/empty.dart';

class FeedPage extends StatelessWidget {
  FeedPage({Key? key}) : super(key: key);

  final FeedPageController controller = Get.find<FeedPageController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: RefreshIndicator(
        onRefresh: controller.refreshPost,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 24, right: 24, top: 12),
              child: header(),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  controller: controller.scrollController,
                  child: Column(
                    children: [
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: _postBody()),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      )),
    );
  }

  Widget header() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "GLINT",
              style: AppTextTheme.T1.copyWith(
                  color: AppColorTheme.BUTTON1,
                  fontFamily: "Tenada",
                  height: 1.4),
            ),
            Image.asset("assets/images/icon.png", width: 36, height: 36),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GTIconButton("assets/images/post.svg", onTap: () {
              Get.toNamed(Routes.post);
            }),
            GTIconButton("assets/images/search.svg", onTap: () {}),
            GTIconButton("assets/images/message.svg", onTap: () {
              Get.toNamed(Routes.chat);
            }),
          ],
        )
      ],
    );
  }

  Widget stories() {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 100, minHeight: 50),
      child: ListView.builder(
        physics: const ClampingScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        itemBuilder: (context, index) => _storyItem(),
      ),
    );
  }

  Widget _storyItem() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 9),
      child: GestureDetector(
        onTap: () {
          Get.toNamed(Routes.story);
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 64,
              width: 64,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: AppColorTheme.BUTTON1,
              ),
            ),
            const SizedBox(height: 8),
            const Text("EXAMPLE", style: AppTextTheme.Main)
          ],
        ),
      ),
    );
  }

  Widget _postBody() {
    return Obx(() {
      if (controller.posts.isEmpty) {
        //포스트가 없어요
        return const Empty(title: "포스트 없음", description: "첫 작성자가 되어보세요!");
      }
      return Column(
        children: [
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: controller.posts.length,
            itemBuilder: (context, index) =>
                FeedItem(post: controller.posts[index]),
          ),
          if (controller.isLoading) LOADINGINDICATOR
        ],
      );
    });
  }
}
