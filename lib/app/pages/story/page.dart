import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glint/app/core/theme/color_theme.dart';
import 'package:glint/app/core/theme/text_theme.dart';
import 'package:glint/app/pages/story/controller.dart';
import 'package:glint/app/pages/story/widget/bottomsheet.dart';
import 'package:glint/app/widgets/constant.dart';

class StoryPage extends StatelessWidget {
  StoryPage({Key? key}) : super(key: key);

  final StoryPageController controller = Get.find<StoryPageController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            controller.obx(
              (_) => GestureDetector(
                onTap: controller.nextStory,
                child: Image.network(
                  controller.imgUrl.value!,
                  fit: BoxFit.cover,
                ),
              ),
              onLoading: LOADINGINDICATOR,
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  Obx(
                    () => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        for (var i = 0; i < 5; i++)
                          Container(
                            height: 10,
                            width: (Get.width - 48) / 6,
                            color: (i == controller.index.value)
                                ? Colors.white
                                : Colors.grey,
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
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
                          ),
                          const SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "EXAMPLE",
                                style: AppTextTheme.T4
                                    .copyWith(color: AppColorTheme.white),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "EXAMPLE",
                                style: AppTextTheme.T7
                                    .copyWith(color: AppColorTheme.white),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              StoryBottomSheet().bottomSheet();
                            },
                            child: const Icon(
                              Icons.more_horiz,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 16),
                          GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: const Icon(
                              Icons.cancel,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
