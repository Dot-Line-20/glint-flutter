import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class DatabaseController extends GetxController {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  Future<DatabaseController> init() async {
    return this;
  }

  Future<void> addData(String collectionPath, dynamic data) async {
    _firebaseFirestore.collection(collectionPath).add(data.toJson());
  }

  Future deleteData(String collectionPath, String id) async {
    _firebaseFirestore.collection(collectionPath).doc(id).delete();
  }

  Future updateData(
      String collectionPath, String id, Map<String, dynamic> update) async {
    _firebaseFirestore.collection(collectionPath).doc(id).update(update);
  }

  getStream(String collectionPath) {
    return _firebaseFirestore.collection(collectionPath).snapshots();
  }
}
