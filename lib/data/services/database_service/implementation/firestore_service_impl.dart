import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dishlocal/data/services/database_service/interface/database_service.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: DatabaseService)
class FirestoreServiceImpl implements DatabaseService {
  final FirebaseFirestore _firestore;

  FirestoreServiceImpl(this._firestore);

  @override
  Future<Map<String, dynamic>?> getDocument({required String collection, required String docId}) async {
    final docSnapshot = await _firestore.collection(collection).doc(docId).get();
    return docSnapshot.data();
  }

  @override
  Future<void> setDocument({required String collection, required String docId, required Map<String, dynamic> data}) {
    return _firestore.collection(collection).doc(docId).set(data);
  }

  @override
  Future<void> updateDocument({required String collection, required String docId, required Map<String, dynamic> data}) {
    return _firestore.collection(collection).doc(docId).update(data);
  }
}
