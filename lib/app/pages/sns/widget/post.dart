import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glint/app/core/theme/color_theme.dart';
import 'package:glint/app/core/theme/text_theme.dart';
import 'package:glint/app/data/models/post.dart';
import 'package:glint/app/data/module/post/service.dart';
import 'package:glint/app/pages/sns/widget/bottomsheet.dart';
import 'package:glint/app/routes/route.dart';
import 'package:glint/app/test/test_model.dart';
import 'package:glint/app/widgets/button.dart';
import 'package:glint/app/widgets/snackbar.dart';
import 'package:lottie/lottie.dart';
import 'package:share_plus/share_plus.dart';

class PostItem extends StatelessWidget {
  PostItem({
    Key? key,
    required this.post,
  }) : super(key: key);
  final Post post;

  final Rx<int> index = 0.obs;
  final Rx<bool> isMore = true.obs;
  final Rx<bool> isLiked = false.obs;
  final PostController postController = Get.find<PostController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Stack(
          children: [
            CarouselSlider(
                items: post.medias.map((e) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      "https://cdn.h2o.vg/images/${e.media.name}.${e.media.type}",
                      fit: BoxFit.fitWidth,
                    ),
                  );
                }).toList(),
                options: CarouselOptions(
                  aspectRatio: 16 / 9,
                  viewportFraction: 1,
                  initialPage: 0,
                  reverse: false,
                  enableInfiniteScroll: false,
                  enlargeCenterPage: true,
                  scrollDirection: Axis.horizontal,
                  onPageChanged: (index, reason) {
                    this.index.value = index;
                  },
                )),
            Positioned(
              top: 10,
              right: 10,
              child: GestureDetector(
                onTap: () {
                  PostBottomSheet().bottomSheet();
                },
                child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColorTheme.Gray3,
                    ),
                    width: 32,
                    height: 32,
                    child: const Icon(Icons.more_horiz)),
              ),
            ),
            Positioned(
              left: 10,
              bottom: 10,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: post.medias.map((e) {
                  int i = post.medias.indexOf(e);
                  return Obx(() => Container(
                        width: 8.0,
                        height: 8.0,
                        margin: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 2.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: index.value == i
                              ? AppColorTheme.Gray2
                              : AppColorTheme.Gray3,
                        ),
                      ));
                }).toList(),
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
                Obx(
                  () => GTIconButton(
                      isLiked.value
                          ? "assets/images/like_true.svg"
                          : "assets/images/like.svg", onTap: () {
                    like(isLiked);
                  }),
                ),
                GTIconButton("assets/images/small_message.svg", onTap: () {
                  Get.toNamed("/sns/${post.id}");
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
              textAlign: TextAlign.start,
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

  void like(Rx<bool> isLiked) {
    //int like = 1;
    isLiked.value = !isLiked.value;

    if (isLiked.value) {
      try {
        postController.likePost(post.id);
      } on DioError catch (e) {
        GTSnackBar.open(e.response!.data["data"][0]["title"]);
      }

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
    } else {
      postController.unlikePost(post.id);
    }
  }
}
