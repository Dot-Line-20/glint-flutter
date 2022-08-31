import 'package:get/get.dart';

class MiddleWare {
  static observer(Routing routing) {
    /// 각 화면의 routes, snackbars, dialogs와 bottomsheets에서 추가하여 받을 수 있습니다.
    /// If you need to enter any of these 3 events directly here,
    /// you must specify that the event is != Than you are trying to do.
    if (routing.current == '/second' && !routing.isDialog!) {
      Get.snackbar("Hi", "You are on second route");
    } else if (routing.current == '/third') {
      //print('last route called');
    }
  }
}
