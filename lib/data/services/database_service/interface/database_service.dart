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

  Future<List<Map<String, dynamic>>> getDocuments({
    required String collection,
    String? orderBy,
    bool descending = false,
    int limit = 10,
    dynamic startAfter,
  });
}
