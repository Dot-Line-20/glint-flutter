import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(44),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //Text("Hello World!!!", style: AppTextTheme.boldBlue_24),
            const SizedBox(height: 8),
            const SizedBox(height: 8),
            ValueBuilder(
              initialValue: false,
              builder: (bool value, Function(bool) updatefn) => Switch(
                value: value,
                onChanged: updatefn,
              ),
            ),
            ObxValue(
                (Rx<bool> data) => Switch(value: data.value, onChanged: data),
                false.obs),
            GetX(builder: (controller) {
              return Text("$controller");
            }),
          ],
        ),
      )),
    );
  }
}
