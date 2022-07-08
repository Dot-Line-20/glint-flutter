import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

class CloudMessageController extends GetxController {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  @override
  void onInit() {
    _initNotification();
    _foregroundEvent();
    super.onInit();
  }

  void _initNotification() {
    _messaging.requestPermission();
    _messaging.setAutoInitEnabled(true);
  }

  void _foregroundEvent() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {}
    });
  }

  Future<String> getToken() async {
    try {
      String? token = await _messaging.getToken();
      return token!;
    } catch (e) {
      return "";
    }
  }
}
