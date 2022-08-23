import 'package:firebase_getx_boilerplate/app/core/theme/text_theme.dart';
import 'package:firebase_getx_boilerplate/app/widgets/button.dart';
import 'package:firebase_getx_boilerplate/app/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController textEditingController = TextEditingController();
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(44),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Hello World!!!", style: AppTextTheme.bold20),
            const SizedBox(height: 8),
            FGBPTextField(textController: textEditingController),
            const SizedBox(height: 8),
            FGBPTextButton(text: "Hello", radius: 10),
            ValueBuilder(
              initialValue: false,
              onUpdate: (value) => print("GOOD"),
              onDispose: () => print("GOOD"),
              builder: (bool value, Function(bool) updatefn) => Switch(
                value: value,
                onChanged: updatefn,
              ),
            ),
            ObxValue(
                (Rx<bool> data) => Switch(value: data.value, onChanged: data),
                false.obs),
            GetX(builder: (controller) {
              return Text("${controller}");
            }),
          ],
        ),
      )),
    );
  }
}
