import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<AuthController> init() async {
    return this;
  }

  Future<String> login(String id, String password) async {
    return "";
  }

  loginWithEmail(String email, String password) async {
    try {
      _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }
}
