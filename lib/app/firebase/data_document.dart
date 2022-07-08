import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class DatabaseManager extends GetxController {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future add(String name, String id, String password) async {
    _firebaseFirestore.collection("example").doc(id).set({});
  }

  Future delete(String name) async {
    _firebaseFirestore.collection("example").doc(name).delete();
  }
}
