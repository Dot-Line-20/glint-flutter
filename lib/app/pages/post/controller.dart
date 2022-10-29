import 'dart:async';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:glint/app/data/module/post/service.dart';
import 'package:glint/app/widgets/snackbar.dart';

class PostPageController extends GetxController {
  final PostController postController = Get.find<PostController>();
  Rx<FilePickerResult?> filePickerResult = Rx(null);

  final Rx<int> _uploadImageCount = Rx(0);
  final Rx<int> _uploadImageTotal = Rx(0);
  Rx<bool> isUploading = false.obs;

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

  onSendProgress(int sent, int total) {
    _uploadImageCount.value = sent;
    _uploadImageTotal.value = total;
  }

  void createPost() async {
    isUploading.value = true;
    try {
      await postController.createPost(
          "임시", contentController.text, filePickerResult.value, onSendProgress);
      Get.back();
    } on DioError catch (e) {
      GTSnackBar.open(e.response!.data["data"][0]["title"]);
    } finally {
      isUploading.value = false;
    }
  }

  void uploadFile() async {
    // if (filePickerResult.value == null) {
    //   return;
    // }

    isUploading.value = true;
    print("UPLOAD FILE ${isUploading.value}");
    _uploadImageCount.value = 0;
    _uploadImageTotal.value = 100;

    // List<int> upload = filePickerResult.value!.isSinglePick
    //     ? await postController.uploadFile(filePickerResult.value!)
    //     : await postController.uploadManyFiles(filePickerResult.value!);

    // 1plus 1sec
    Timer timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _uploadImageCount.value += 10;
      if (_uploadImageCount.value == 100) {
        isUploading.value = false;
        timer.cancel();
        print("END");
      }
    });
  }

  int get fileCount => filePickerResult.value?.files.length ?? 0;
  String filePath(int index) => filePickerResult.value?.files[index].path ?? "";
  Uint8List fileBytes(int index) =>
      filePickerResult.value?.files[index].bytes ?? Uint8List(0);

  double get progress =>
      (_uploadImageCount.value / _uploadImageTotal.value) * 100;
}