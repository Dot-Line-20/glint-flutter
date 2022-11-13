import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glint/app/core/theme/color_theme.dart';
import 'package:glint/app/core/theme/text_theme.dart';
import 'package:glint/app/core/util/constant.dart';
import 'package:glint/app/data/module/post/post.dart';
import 'package:glint/app/data/module/post/controller.dart';
import 'package:glint/app/data/module/user/controller.dart';
import 'package:glint/app/pages/sns/widget/bottomsheet.dart';
import 'package:glint/app/pages/sns/widget/video_player.dart';
import 'package:glint/app/widgets/button.dart';
import 'package:share_plus/share_plus.dart';

class PostItem extends StatefulWidget {
  const PostItem({Key? key, required this.post}) : super(key: key);
  final Post post;

  @override
  State<PostItem> createState() => _PostItemState();
}

class _PostItemState extends State<PostItem> {
  int index = 0;
  bool isMore = true;
  bool isLiked = false;

  @override
  void initState() {
    isLiked = widget.post.isLiked;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: UserController.to.getOtherUserInfo(widget.post.userId),
        builder: (contexnt, snapshot) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),
              if (snapshot.hasData) _postHeader(snapshot.data),
              const SizedBox(height: 10),
              if (widget.post.medias.isNotEmpty) _postImage(),
              const SizedBox(height: 16),
              _postAction(),
              const SizedBox(height: 16),
              _postContent(),
              const SizedBox(height: 20),
              const Divider(color: AppColorTheme.Gray4, thickness: 1),
            ],
          );
        });
  }

  GestureDetector _postContent() {
    return GestureDetector(
      onTap: () {
        setState(() {
          isMore = !isMore;
        });
        //print(isMore.value);
      },
      child: Text(
        widget.post.content.replaceAll("\n", " "),
        style: AppTextTheme.Main,
        textAlign: TextAlign.start,
        overflow: isMore ? TextOverflow.ellipsis : TextOverflow.visible,
      ),
    );
  }

  Row _postAction() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            GTIconButton(
                isLiked
                    ? "assets/images/like_true.svg"
                    : "assets/images/like.svg",
                onTap: like),
            Text(widget.post.count.likes.toString(),
                style: AppTextTheme.Explain),
            GTIconButton("assets/images/small_message.svg", onTap: () {
              Get.toNamed("/sns/${widget.post.id}");
            }),
            Text(widget.post.count.comments.toString(),
                style: AppTextTheme.Explain),
          ],
        ),
        GTIconButton("assets/images/share.svg", onTap: () {
          Share.share("T");
        }),
      ],
    );
  }

  Stack _postImage() {
    return Stack(
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
    );
  }

  Row _postHeader(user) {
    return Row(
      children: [
        Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColorTheme.BUTTON1,
            image: DecorationImage(
              image: NetworkImage(
                user.profile ?? LOADING,
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user.name ?? "",
                style: AppTextTheme.T6,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              const SizedBox(height: 4),
              Text(
                user.email ?? "",
                style: AppTextTheme.T6.copyWith(color: AppColorTheme.Gray2),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            PostBottomSheet().bottomSheet();
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
    );
  }

  Widget networkFile(Medias e) {
    if (e.media.type != "mp4" && e.media.type != "mov") {
      return AspectRatio(
        aspectRatio: 16 / 9,
        child: Image.network(
          e.url(),
          fit: BoxFit.cover,
        ),
      );
    }

    return AspectRatio(
      aspectRatio: 16 / 9,
      child: VideoPlayerWidget(
        url: e.url(isVideo: true),
      ),
    );
  }

  void like() {
    if (!isLiked) {
      PostController.to.likePost(widget.post.id);
      setState(() {
        isLiked = true;
        widget.post.count.likes++;
      });
    } else {
      PostController.to.unlikePost(widget.post.id);
      setState(() {
        isLiked = false;
        widget.post.count.likes--;
      });
    }
  }
}
