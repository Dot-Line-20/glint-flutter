import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:glint/app/data/models/category.dart';
import 'package:glint/app/data/module/category/service.dart';

class CategoryPageController extends GetxController with StateMixin {
  final CategoryController categoryController = Get.find<CategoryController>();
  final TextEditingController titleController = TextEditingController();
  final Rx<String?> title = Rx("");
  Rx<List<Category>> categories = Rx([]);

  Rx<List<Category>> selectedCategories = Rx([]);

  @override
  void onInit() async {
    change(null, status: RxStatus.loading());
    categories.value = await categoryController.getCategories();
    change(null, status: RxStatus.success());

    titleController.addListener(() {
      title.value = titleController.text;
    });
    debounce(title, (_) async {
      categories.value =
          await categoryController.searchCategories(title.value!);
    }, time: const Duration(milliseconds: 500));

    super.onInit();
  }

  void selectCategory(int index) {
    //print(categories.value[index].id);
    if (selectedCategories.value
        .any((element) => element.id == categories.value[index].id)) {
      selectedCategories.value
          .removeWhere((element) => element.id == categories.value[index].id);
    } else {
      selectedCategories.value.add(categories.value[index]);
    }
    selectedCategories.refresh();
    //print(selectedCategories.value.map((e) => "${e.name} | ${e.id}"));
  }

  bool checkSelected(int index) {
    return selectedCategories.value
        .any((element) => element.id == categories.value[index].id);
  }

  Future<void> createCategory() async {
    if (title.value!.isEmpty) {
      return;
    }
    try {
      change(null, status: RxStatus.loading());
      await categoryController.createCategory(title.value!);
      categories.value =
          await categoryController.searchCategories(title.value!);
      change(null, status: RxStatus.success());
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
    }
  }

  sendData() {
    Get.back(result: selectedCategories.value);
  }
}
