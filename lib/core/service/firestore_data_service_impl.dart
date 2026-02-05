import 'package:cloud_firestore/cloud_firestore.dart';
import 'firestore_data_service.dart';

class FirestoreDataServiceImpl implements FireStoreDataService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Future<void> addData({
    required String path,
    required Map<String, dynamic> data,
    String? documentId,
  }) async {
    if (documentId != null) {
      await firestore.collection(path).doc(documentId).set(data);
    } else {
      await firestore.collection(path).add(data);
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getData({required String path}) async {
    final result = await firestore.collection(path).get();
    return result.docs.map((doc) => {'id': doc.id, ...doc.data()}).toList();
  }

  @override
  Future<Map<String, dynamic>?> getDoc({
    required String path,
    required String documentId,
  }) async {
    final snap = await firestore.collection(path).doc(documentId).get();
    if (!snap.exists) return null;
    return {'id': snap.id, ...snap.data()!};
  }

  @override
  Future<void> addBookedData({
    required String path,
    required Map<String, dynamic> data,
    required String documentId,
    required String secPath
  }) async {
    await firestore
        .collection(path)
        .doc(documentId)
        .collection(secPath)
        .add(data);
  }

  @override
  Future<List<Map<String, dynamic>>> getBookedData({
    required String path,
    required String documentId,
  }) async {
    final result = await firestore
        .collection(path)
        .doc(documentId)
        .collection('booked')
        .get();

    return result.docs.map((doc) => {'id': doc.id, ...doc.data()}).toList();
  }

  @override
  Future<void> updateData({
    required String path,
    required Map<String, dynamic> data,
    required String documentId,
  }) async {
    await firestore
        .collection(path)
        .doc(documentId)
        .set(data, SetOptions(merge: true));
  }

}
