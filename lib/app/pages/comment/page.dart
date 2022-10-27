import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:glint/app/core/theme/color_theme.dart';
import 'package:glint/app/core/theme/text_theme.dart';
import 'package:glint/app/pages/comment/widget/bottomsheet.dart';
import 'package:glint/app/widgets/button.dart';

class CommentPage extends StatelessWidget {
  const CommentPage({Key? key}) : super(key: key);

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
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return item();
                  },
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  hintText: "Add a comment...",
                  hintStyle: AppTextTheme.regularGrey3_14,
                  border: InputBorder.none,
                  suffixIcon: SvgPicture.asset(
                    "assets/images/rabbi.svg",
                    width: 24,
                    height: 24,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget item() {
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
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "EXAMPLE",
                        style: AppTextTheme.semiboldGrey1_14,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                      SizedBox(height: 4),
                      Text(
                        "EXAMPLE",
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
          const Text(
            "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).",
            style: AppTextTheme.regularGrey1_14,
          ),
        ],
      ),
    );
  }
}
