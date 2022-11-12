import 'package:get/get.dart';

class OrientationService extends GetxService {
  static OrientationService get to => Get.find();

  final _isLandscape = false.obs;
  bool get isLandscape => _isLandscape.value;

  void updateOrientation(bool isLandscape) {
    _isLandscape(isLandscape);
  }
}
