import 'dart:async';
import 'dart:math';

import 'package:get/get.dart';
import 'package:glint/app/test/test_api.dart';

class StoryPageController extends GetxController with StateMixin {
  ImageApi imageApi = ImageApi();
  Rx<String?> imgUrl = Rx(null);
  int count = Random().nextInt(45643123);
  Rx<int> index = 0.obs;
  Rx<double> width = ((Get.width - 48) / 6).obs;

  Timer? timer;

  @override
  void onClose() {
    index.value = 0;
    timer?.cancel();
    super.onClose();
  }

  @override
  void onInit() async {
    await getImage();
    // Timer.run(() {
    //   // Timer.run() is used to avoid the error "setState() or markNeedsBuild() called during build."
    //   timer = Timer.periodic(const Duration(seconds: 10), (timer) async {
    //     nextStory();
    //   });
    // });
  }

  getImage() async {
    change(null, status: RxStatus.loading());
    imgUrl.value = await imageApi.getImage(count);
    change(null, status: RxStatus.success());
  }

  nextStory() {
    index.value += 1;
    count += 5;

    if (index.value >= 5) {
      Get.back();
    } else {
      getImage();
    }
  }
}
