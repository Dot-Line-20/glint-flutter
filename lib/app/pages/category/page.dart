import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:glint/app/core/theme/text_theme.dart';
import 'package:glint/app/pages/category/controller.dart';
import 'package:glint/app/widgets/button.dart';
import 'package:glint/app/widgets/textfield.dart';

class CategoryPage extends StatelessWidget {
  CategoryPage({Key? key}) : super(key: key);

  final CategoryPageController controller = Get.find<CategoryPageController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "카테고리",
          style: AppTextTheme.T4,
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
              child: Obx(() => categoryGrid()),
            ),
          ],
        ),
      )),
    );
  }

  Widget _notExist() {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset("assets/images/none.svg",
                      width: 150, height: 150),
                  const SizedBox(height: 16),
                  const Text("검색한 카테고리가 없네요", style: AppTextTheme.T4),
                  const SizedBox(height: 16),
                  const Text.rich(
                    TextSpan(
                      style: AppTextTheme.Explain,
                      children: [
                        TextSpan(text: "추가하기 버튼을 통해\n"),
                        TextSpan(text: "카테고리를 추가할 수 있습니다"),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          GTMediumTextButton(text: "추가하기", onTap: controller.createCategory),
        ],
      ),
    );
  }

  Widget categoryGrid() {
    if (controller.categories.value.isEmpty) {
      return _notExist();
    }

    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisSpacing: 16, crossAxisCount: 3),
        shrinkWrap: true,
        itemCount: controller.categories.value.length,
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
                            child:
                                Text(controller.categories.value[index].name)),
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
                  Text(controller.categories.value[index].name)
                ],
              ),
            ),
          );
        });
  }
}
