import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:glint/app/core/theme/text_theme.dart';
import 'package:glint/app/routes/route.dart';
import 'package:glint/app/widgets/button.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

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
            stories(),
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
            color: Colors.red,
          ),
          height: 44,
          width: 44,
        ),
        Row(
          children: [
            GTIconButton("assets/icons/post.svg", onTap: () {}),
            const SizedBox(width: 18),
            GTIconButton("assets/icons/post.svg", onTap: () {}),
            const SizedBox(width: 18),
            GTIconButton("assets/icons/post.svg", onTap: () {}),
          ],
        )
      ],
    );
  }

  Widget stories() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      itemCount: 10,
      itemBuilder: (context, index) => _storyItem(),
    );
  }

  Widget _storyItem() {
    return Column(
      children: [
        Container(
          height: 64,
          width: 64,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Colors.red,
          ),
        ),
        const SizedBox(height: 8),
        const Text("EXAMPLE")
      ],
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
          width: 350,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Colors.red,
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
                    color: Colors.red,
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
                SvgPicture.asset("assets/image/"),
                const SizedBox(width: 16),
                SvgPicture.asset("assets/image/"),
                const SizedBox(width: 16),
                SvgPicture.asset("assets/image/"),
              ],
            )
          ],
        ),
        const SizedBox(height: 16),
        const Text(
            "오는 피어나듯이 가슴속에 아이들의 이런 딴은 이름과, 내일 내 까닭입니다. 가득 추억과 위에 하나에 덮어 피어나듯이... 더보기"),
      ],
    );
  }
}
