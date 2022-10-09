import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glint/app/core/theme/color_theme.dart';
import 'package:glint/app/widgets/button.dart';

class SnsPage extends StatelessWidget {
  const SnsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            header(),
            const SizedBox(height: 10),
            stories(),
            const SizedBox(height: 10),
            Expanded(child: body()),
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
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: 10,
        itemBuilder: (context, index) => _storyItem(),
      ),
    );
  }

  Widget _storyItem() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 9),
      child: Column(
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
          const Text("EXAMPLE")
        ],
      ),
    );
  }

  Widget body() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 10,
      itemBuilder: (context, index) => _posItem(),
    );
  }

  Widget _posItem() {
    return Column(
      children: [
        Container(
          height: 350,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: AppColorTheme.BUTTON1,
          ),
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
                    Text("EXAMPLE"),
                    SizedBox(height: 4),
                    Text("EXAMPLE"),
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
        const Text(
            "오는 피어나듯이 가슴속에 아이들의 이런 딴은 이름과, 내일 내 까닭입니다. 가득 추억과 위에 하나에 덮어 피어나듯이... 더보기"),
        const SizedBox(height: 16),
      ],
    );
  }
}
