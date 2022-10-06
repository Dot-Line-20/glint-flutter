import 'package:fluttertoast/fluttertoast.dart';

class GTToast {
  static void open(String msg) {
    Fluttertoast.showToast(msg: msg);
  }
}
