import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_launcher_icons/main.dart';
import 'package:get/get.dart';
import 'package:glint/app/core/theme/color_theme.dart';
import 'package:glint/app/core/theme/text_theme.dart';
import 'package:glint/app/data/models/post.dart';
import 'package:glint/app/data/models/user.dart';
import 'package:glint/app/data/module/post/service.dart';
import 'package:glint/app/data/module/user/service.dart';
import 'package:glint/app/pages/sns/widget/bottomsheet.dart';
import 'package:glint/app/pages/sns/widget/video_player.dart';
import 'package:glint/app/routes/route.dart';
import 'package:glint/app/test/test_model.dart';
import 'package:glint/app/widgets/button.dart';
import 'package:glint/app/widgets/snackbar.dart';
import 'package:lottie/lottie.dart';
import 'package:share_plus/share_plus.dart';
import 'package:video_player/video_player.dart';

class PostItem extends StatefulWidget {
  const PostItem({Key? key, required this.post}) : super(key: key);
  final Post post;

  @override
  State<PostItem> createState() => _PostItemState();
}

class _PostItemState extends State<PostItem> {
  Rx<User?> user = Rx(null);
  int index = 0;
  bool isMore = true;
  bool isLiked = false;
  final PostController postController = Get.find<PostController>();
  final UserController userController = Get.find<UserController>();

  @override
  void initState() {
    isLiked = widget.post.isLiked;
    userController
        .getOtherUserInfo(widget.post.userId)
        .then((value) => user.value = value);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        Row(
          children: [
            Obx(
              () => Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColorTheme.BUTTON1,
                  image: DecorationImage(
                    image: NetworkImage(
                        "https://cdn.h2o.vg/images/${user.value?.media?.name ?? ""}.${user.value?.media?.type ?? ""}"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Obx(
                () => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.value?.name ?? "",
                      style: AppTextTheme.semiboldGrey1_14,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      user.value?.email ?? "",
                      style: AppTextTheme.lightGray3_14,
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
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
          ],
        ),
        const SizedBox(height: 10),
        if (widget.post.medias.isNotEmpty)
          Stack(
            children: [
              CarouselSlider(
                  items: widget.post.medias.map((e) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: networkFile(e),
                    );
                  }).toList(),
                  options: CarouselOptions(
                    aspectRatio: 1,
                    viewportFraction: 1,
                    initialPage: 0,
                    reverse: false,
                    enableInfiniteScroll: false,
                    enlargeCenterPage: true,
                    scrollDirection: Axis.horizontal,
                    onPageChanged: (index, reason) {
                      setState(() {
                        this.index = index;
                      });
                    },
                  )),
              Positioned.fill(
                bottom: 10,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: widget.post.medias.map((e) {
                      int i = widget.post.medias.indexOf(e);
                      return Container(
                        width: 8.0,
                        height: 8.0,
                        margin: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 2.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: index == i
                              ? AppColorTheme.BUTTON1
                              : AppColorTheme.Gray3,
                        ),
                      );
                    }).toList(),
                  ),
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
                GTIconButton(
                    isLiked
                        ? "assets/images/like_true.svg"
                        : "assets/images/like.svg", onTap: () {
                  like(isLiked);
                }),
                GTIconButton("assets/images/small_message.svg", onTap: () {
                  Get.toNamed("/sns/${widget.post.id}");
                }),
              ],
            ),
            GTIconButton("assets/images/share.svg", onTap: () {
              Share.share("T");
            }),
          ],
        ),
        const SizedBox(height: 16),
        GestureDetector(
          onTap: () {
            setState(() {
              isMore = !isMore;
            });
            //print(isMore.value);
          },
          child: Text(
            widget.post.content.replaceAll("\n", " "),
            style: AppTextTheme.lightGray1Height_14,
            textAlign: TextAlign.start,
            overflow: isMore ? TextOverflow.ellipsis : TextOverflow.visible,
          ),
        ),
        const SizedBox(height: 16),
        _categoryList(),
        const SizedBox(height: 20),
        const Divider(color: AppColorTheme.Gray4, thickness: 1),
      ],
    );
  }

  Widget _categoryList() {
    if (widget.post.categories.isEmpty) {
      return Container();
    }
    return SizedBox(
      height: 30,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: widget.post.categories.length,
        itemBuilder: (context, index) {
          // radius random color
          return Container(
            margin: const EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: AppColorTheme.BUTTON1,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Text(
                widget.post.categories[index].category.name,
                style: AppTextTheme.boldWhite_14,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget networkFile(Medias e) {
    if (e.media.type != "mp4" && e.media.type != "mov") {
      return AspectRatio(
        aspectRatio: 16 / 9,
        child: Image.network(
          "https://cdn.h2o.vg/images/${e.media.name}.${e.media.type}",
          fit: BoxFit.cover,
        ),
      );
    }

    return AspectRatio(
      aspectRatio: 16 / 9,
      child: VideoPlayerWidget(
        url: "https://cdn.h2o.vg/videos/${e.media.name}.${e.media.type}",
      ),
    );
  }

  void like(bool isLiked) {
    setState(() {
      this.isLiked = !isLiked;
    });

    if (!isLiked) {
      try {
        postController.likePost(widget.post.id);
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
      postController.unlikePost(widget.post.id);
    }
  }
}

class PostItems extends StatelessWidget {
  PostItems({
    Key? key,
    required this.post,
  }) : super(key: key);
  final Post post;

  final Rx<int> index = 0.obs;
  final Rx<bool> isMore = true.obs;
  static Rx<bool> isLiked = false.obs;
  final PostController postController = Get.find<PostController>();
  final UserController userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    //isLiked.value = post.isLiked;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        if (post.medias.isNotEmpty)
          Stack(
            children: [
              CarouselSlider(
                  items: post.medias.map((e) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: networkFile(e),
                    );
                  }).toList(),
                  options: CarouselOptions(
                    aspectRatio: 1,
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
                    return Container(
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
                    );
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
                    child: Image.network(
                      "https://cdn.h2o.vg/images/",
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userController.getUser(post.userId)?.name ?? "",
                          style: AppTextTheme.semiboldGrey1_14,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          userController.getUser(post.userId)?.email ?? "",
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
                GTIconButton(
                    isLiked.value
                        ? "assets/images/like_true.svg"
                        : "assets/images/like.svg", onTap: () {
                  like(isLiked);
                }),
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
        GestureDetector(
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
        const SizedBox(height: 20),
        const Divider(color: AppColorTheme.Gray4, thickness: 1),
      ],
    );
  }

  Widget networkFile(Medias e) {
    if (e.media.type != "mp4" && e.media.type != "mov") {
      return Image.network(
        "https://cdn.h2o.vg/images/${e.media.name}.${e.media.type}",
        width: double.infinity,
        fit: BoxFit.fitWidth,
      );
    }

    return VideoPlayerWidget(
      url: "https://cdn.h2o.vg/videos/${e.media.name}.${e.media.type}",
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
