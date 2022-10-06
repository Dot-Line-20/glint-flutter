import 'package:flutter/material.dart';
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
            GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.schedule);
                },
                child: const Text("Hello World!!!",
                    style: AppTextTheme.boldBlue_24)),
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

  Widget story() {
    return Container(
      height: 100,
      width: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: Colors.red,
      ),
    );
  }
}
