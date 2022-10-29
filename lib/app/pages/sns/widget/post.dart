import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glint/app/core/theme/color_theme.dart';
import 'package:glint/app/core/theme/text_theme.dart';
import 'package:glint/app/data/models/post.dart';
import 'package:glint/app/pages/sns/widget/bottomsheet.dart';
import 'package:glint/app/routes/route.dart';
import 'package:glint/app/test/test_model.dart';
import 'package:glint/app/widgets/button.dart';
import 'package:lottie/lottie.dart';
import 'package:share_plus/share_plus.dart';

class PostItem extends StatelessWidget {
  PostItem({
    Key? key,
    required this.post,
  }) : super(key: key);
  final Post post;

  final Rx<bool?> isMore = true.obs;
  final Rx<bool?> isLiked = false.obs;

  @override
  Widget build(BuildContext context) {
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
            CarouselSlider(
                items: post.medias.map((e) {
                  return Image.network(
                    "https://cdn.h2o.vg/images/${e.media.name}.${e.media.type}",
                    width: double.infinity,
                  );
                }).toList(),
                options: CarouselOptions(
                  height: 350,
                  aspectRatio: 16 / 9,
                  viewportFraction: 0.8,
                  initialPage: 0,
                  reverse: false,
                  enlargeCenterPage: true,
                  scrollDirection: Axis.horizontal,
                )),
            Positioned(
              top: 10,
              right: 10,
              child: GestureDetector(
                onTap: () {
                  PostBottomSheet().bottomSheet();
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
            Expanded(
              child: Row(
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
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          post.title,
                          style: AppTextTheme.semiboldGrey1_14,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          "EXAMPLE",
                          style: AppTextTheme.lightGray3_14,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                GTIconButton("assets/images/like.svg", onTap: () {
                  like(isLiked);
                }),
                GTIconButton("assets/images/small_message.svg", onTap: () {
                  Get.toNamed(Routes.comment);
                }),
                GTIconButton("assets/images/share.svg", onTap: () {
                  Share.share("T");
                }),
              ],
            )
          ],
        ),
        const SizedBox(height: 16),
        Obx(
          () => GestureDetector(
            onTap: () {
              isMore.toggle();
              //print(isMore.value);
            },
            child: Text(
              post.content.replaceAll("\n", " "),
              style: AppTextTheme.lightGray1Height_14,
              overflow:
                  isMore.value! ? TextOverflow.ellipsis : TextOverflow.visible,
            ),
          ),
        ),
        const SizedBox(height: 20),
        const Divider(color: AppColorTheme.Gray4, thickness: 1),
      ],
    );
  }

  void like(Rx<bool?> isLiked) {
    //int like = 1;
    isLiked.value = !isLiked.value!;
    Get.dialog(Container(
      color: Colors.transparent,
      child: Lottie.asset(
        "assets/lottie/like.json",
        repeat: false,
      ),
    ));
    Future.delayed(const Duration(seconds: 1), () {
      Get.back();
    });
    //like -= 1;
    isLiked.value = !isLiked.value!;
  }
}
