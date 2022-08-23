import 'dart:developer';

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

  Future<UserCredential?> loginWithEmail(String email, String password) async {
    try {
      final credentials = _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return credentials;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        log('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        log('Wrong password provided for that user.');
      }
      return null;
    }
  }
}
