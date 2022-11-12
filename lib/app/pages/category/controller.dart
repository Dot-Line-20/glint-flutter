import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:glint/app/data/module/category/category.dart';
import 'package:glint/app/data/module/category/controller.dart';

class CategoryPageController extends GetxController with StateMixin {
  final CategoryController categoryController = Get.find<CategoryController>();
  final TextEditingController titleController = TextEditingController();
  final Rx<String?> title = Rx("");
  Rx<List<Category>> selectedCategories = Rx([]);

  List<Category> get categories => categoryController.categories;

  @override
  void onInit() async {
    titleController.addListener(() {
      title.value = titleController.text;
    });
    debounce(title, (_) async {
      await categoryController.searchCategories(title.value!);
    }, time: const Duration(milliseconds: 500));

    super.onInit();
  }

  void selectCategory(int index) {
    //print(categories.value[index].id);
    if (selectedCategories.value
        .any((element) => element.id == categories[index].id)) {
      selectedCategories.value
          .removeWhere((element) => element.id == categories[index].id);
    } else {
      selectedCategories.value.add(categories[index]);
    }
    selectedCategories.refresh();
    //print(selectedCategories.value.map((e) => "${e.name} | ${e.id}"));
  }

  bool checkSelected(int index) {
    return selectedCategories.value
        .any((element) => element.id == categories[index].id);
  }

  Future<void> createCategory() async {
    if (title.value!.isEmpty) {
      return;
    }
    await categoryController.createCategory(title.value!);
  }

  sendData() {
    Get.back(result: selectedCategories.value);
  }
}
