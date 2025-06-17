abstract class DatabaseService {
  Future<Map<String, dynamic>?> getDocument({
    required String collection,
    required String docId,
  });
  Future<void> setDocument({
    required String collection,
    required String docId,
    required Map<String, dynamic> data,
  });
  Future<void> updateDocument({
    required String collection,
    required String docId,
    required Map<String, dynamic> data,
  });
}
