import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:glint/app/data/module/post/service.dart';

class PostPageController extends GetxController {
  final PostController postController = Get.find<PostController>();
  Rx<FilePickerResult?> filePickerResult = Rx(null);

  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  void getFileFromPicker() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['gif', 'jpg', "jpeg", 'png', "mp4", "mov"],
    );

    if (result != null) {
      filePickerResult.value = result;
    } else {
      // User canceled the picker
    }
  }

  void createPost() async {
    await postController.createPost("임시", "임시야임시완", filePickerResult.value);
  }
}
