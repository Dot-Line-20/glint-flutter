import 'package:fluttertoast/fluttertoast.dart';

class FGBPToast {
  static void open(String msg) {
    Fluttertoast.showToast(msg: msg);
  }
}
