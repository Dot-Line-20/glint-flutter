import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glint/app/data/models/category.dart';
import 'package:glint/app/data/module/category/service.dart';
import 'package:glint/app/widgets/button.dart';
import 'package:glint/app/widgets/textfield.dart';

class CategoryDialog {
  final CategoryController controller = Get.find<CategoryController>();

  Future<int?> show(BuildContext context, List<Category> categories) {
    return showDialog<int>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('카테고리'),
          content: Scaffold(
            body: SingleChildScrollView(
                child: Column(
              children: [
                const GTTextField(hintText: "카테고리 검색"),
                const SizedBox(height: 16),
                ...categories.map((category) {
                  return Row(
                    children: [
                      GTIconButton(
                        "assets/images/checkbox.svg",
                        onTap: () {},
                      ),
                      const SizedBox(width: 16),
                      Text(category.name),
                    ],
                  );
                }).toList(),
                GTMediumTextButton(
                  text: "카테고리 추가",
                  onTap: () {},
                )
              ],
            )),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('취소'),
            ),
          ],
        );
      },
    );
  }
}
