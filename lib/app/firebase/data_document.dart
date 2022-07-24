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

  Future<void> addDataFromId(
      String collectionPath, String id, dynamic data) async {
    _firebaseFirestore.collection(collectionPath).doc(id).set(data.toJson());
  }

  Future<void> addDataFromIdWithJson(
      String collectionPath, String id, dynamic data) async {
    _firebaseFirestore.collection(collectionPath).doc(id).set(data);
  }

  Future<void> updateDataFromIdWithJson(
      String collectionPath, String id, dynamic data) async {
    _firebaseFirestore.collection(collectionPath).doc(id).update(data);
  }

  Future deleteData(String collectionPath, String id) async {
    _firebaseFirestore.collection(collectionPath).doc(id).delete();
  }

  Future getData(String collectionPath) async {
    return _firebaseFirestore.collection(collectionPath).getSavy();
  }

  Future getSortedData(String collectionPath,
      {String orderby = "createdAt"}) async {
    return _firebaseFirestore
        .collection(collectionPath)
        .orderBy(orderby)
        .getSavy();
  }

  Future getDataFromId(String collectionPath, String id) async {
    return _firebaseFirestore.collection(collectionPath).doc(id).getSavy();
  }

  Future getDataFromIdNotCache(String collectionPath, String id) async {
    return _firebaseFirestore.collection(collectionPath).doc(id).get();
  }

  getStream(String collectionPath) {
    return _firebaseFirestore.collection(collectionPath).snapshots();
  }

  getSortedStream(String collectionPath, {String orderby = "time"}) {
    return _firebaseFirestore
        .collection(collectionPath)
        .orderBy(orderby)
        .snapshots();
  }

  Future clearData(String collectionPath) async {
    final snapshot =
        await _firebaseFirestore.collection(collectionPath).getSavy();
    for (var doc in snapshot.docs) {
      _firebaseFirestore.collection(collectionPath).doc(doc.id).delete();
    }
  }

  Future clearSetData(String collectionPath, dynamic data) async {
    final snapshot =
        await _firebaseFirestore.collection(collectionPath).getSavy();
    for (var doc in snapshot.docs) {
      _firebaseFirestore.collection(collectionPath).doc(doc.id).update(data);
    }
  }
}

extension FirestoreDocumentExtension on DocumentReference {
  Future<DocumentSnapshot> getSavy() async {
    try {
      DocumentSnapshot ds = await get(const GetOptions(source: Source.cache));
      if (ds == null) return get(const GetOptions(source: Source.server));
      return ds;
    } catch (_) {
      return get(const GetOptions(source: Source.server));
    }
  }
}

extension FirestoreQueryExtension on Query {
  Future<QuerySnapshot> getSavy() async {
    try {
      QuerySnapshot qs = await get(const GetOptions(source: Source.cache));
      if (qs.docs.isEmpty) return get(const GetOptions(source: Source.server));
      return qs;
    } catch (_) {
      return get(const GetOptions(source: Source.server));
    }
  }
}
