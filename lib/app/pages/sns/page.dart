import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:glint/app/core/theme/color_theme.dart';
import 'package:glint/app/core/theme/text_theme.dart';
import 'package:glint/app/widgets/button.dart';

class SnsPage extends StatelessWidget {
  const SnsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
              child: header(),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    stories(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: body(),
                    ),
                  ],
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
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: AppColorTheme.BUTTON1,
          ),
          height: 44,
          width: 44,
        ),
        Row(
          children: [
            GTIconButton("assets/images/post.svg", onTap: () {}),
            GTIconButton("assets/images/search.svg", onTap: () {}),
            GTIconButton("assets/images/message.svg", onTap: () {}),
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
          const Text("EXAMPLE", style: AppTextTheme.mediumGray1_12)
        ],
      ),
    );
  }

  Widget body() {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 10,
      itemBuilder: (context, index) => _posItem(),
    );
  }

  Widget _posItem() {
    final Rx<bool> isMore = true.obs;

    return Column(
      children: [
        const SizedBox(height: 10),
        Stack(
          children: [
            Container(
              height: 350,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: AppColorTheme.BUTTON1,
              ),
            ),
            Positioned(
              top: 10,
              right: 10,
              child: GestureDetector(
                onTap: () {
                  AlertClass().bottomSheet();
                },
                child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.6),
                    ),
                    width: 32,
                    height: 32,
                    child: const Icon(Icons.more_horiz)),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: AppColorTheme.BUTTON1,
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text("EXAMPLE", style: AppTextTheme.semiboldGrey1_14),
                    SizedBox(height: 4),
                    Text(
                      "EXAMPLE",
                      style: AppTextTheme.lightGray3_14,
                    ),
                  ],
                ),
              ],
            ),
            Row(
              children: [
                SvgPicture.asset("assets/images/like.svg"),
                const SizedBox(width: 16),
                SvgPicture.asset("assets/images/small_message.svg"),
                const SizedBox(width: 16),
                SvgPicture.asset("assets/images/share.svg"),
              ],
            )
          ],
        ),
        const SizedBox(height: 16),
        Obx(
          () => GestureDetector(
            onTap: () {
              isMore.toggle();
            },
            child: Text(
              "오는 피어나듯이 가슴속에 아이들의 이런 딴은 이름과, 내일 내 까닭입니다. 가득 추억과 위에 하나에 덮어 피어나듯이",
              style: AppTextTheme.lightGray1Height_14,
              overflow:
                  isMore.value ? TextOverflow.ellipsis : TextOverflow.visible,
            ),
          ),
        ),
        const SizedBox(height: 20),
        const Divider(color: AppColorTheme.Gray4, thickness: 1),
      ],
    );
  }
}

class AlertClass {
  void bottomSheet() {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        context: Get.overlayContext!,
        builder: (context) {
          return Container(
            color: Colors.white,
            height: 140,
            child: Padding(
              padding: const EdgeInsets.all(22),
              child: Column(
                children: [
                  Center(
                    child: Container(
                      decoration: const BoxDecoration(
                          color: AppColorTheme.Gray3,
                          borderRadius: BorderRadius.all(Radius.circular(100))),
                      height: 5,
                      width: 100,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: AppColorTheme.Gray5,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12.0),
                            child: Column(
                              children: [
                                SvgPicture.asset(
                                    "assets/images/broken_heart.svg"),
                                const Text(
                                  "팔로우 취소",
                                  style: AppTextTheme.mediumGray1_12,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: AppColorTheme.Gray5,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12.0),
                            child: Column(
                              children: [
                                SvgPicture.asset("assets/images/spam.svg"),
                                const Text(
                                  "신고하기",
                                  style: AppTextTheme.mediumRed_12,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}
