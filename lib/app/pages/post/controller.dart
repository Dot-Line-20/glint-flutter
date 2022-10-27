import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:glint/app/data/module/post/service.dart';

class PostPageController extends GetxController {
  final PostService postService = Get.find<PostService>();
  Rx<FilePickerResult?> filePickerResult = Rx(null);

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

  void createPost(String title, String content) async {
    await postService.createPost(title, content, filePickerResult.value);
  }
}
