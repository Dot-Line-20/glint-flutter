import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:glint/app/core/theme/text_theme.dart';
import 'package:glint/app/pages/category/controller.dart';
import 'package:glint/app/widgets/empty.dart';
import 'package:glint/app/widgets/textfield.dart';

class CategoryPage extends StatelessWidget {
  CategoryPage({Key? key}) : super(key: key);

  final CategoryPageController controller = Get.find<CategoryPageController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "카테고리",
        ),
        actions: [
          TextButton(
            onPressed: controller.sendData,
            child: const Text(
              "선택하기",
              style: AppTextTheme.Main,
            ),
          )
        ],
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            GTTextFormField(
              hintText: "카테고리를 검색하세요",
              enableInteractiveSelection: false,
              controller: controller.titleController,
            ),
            const SizedBox(height: 8),
            Expanded(
              child: categoryGrid(),
            ),
          ],
        ),
      )),
    );
  }

  Widget categoryGrid() {
    return Obx(() {
      if (controller.categories.isEmpty) {
        return Wrap(
          children: const [
            Empty(title: "카테고리 없음", description: "새로운 카테고리를 만들어보세요"),
          ],
        );
      }

      return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 16, crossAxisCount: 3),
          shrinkWrap: true,
          itemCount: controller.categories.length,
          itemBuilder: (context, index) {
            return Obx(
              () => GestureDetector(
                onTap: () => controller.selectCategory(index),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: 90,
                          height: 90,
                          decoration: const BoxDecoration(
                            color: Colors.grey,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                              child: Text(controller.categories[index].name)),
                        ),
                        //selected
                        if (controller.checkSelected(index))
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: Container(
                              width: 20,
                              height: 20,
                              decoration: const BoxDecoration(
                                color: Colors.blue,
                                shape: BoxShape.circle,
                              ),
                              child: const Center(
                                child: Icon(
                                  Icons.check,
                                  size: 12,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                    Text(controller.categories[index].name)
                  ],
                ),
              ),
            );
          });
    });
  }
}
