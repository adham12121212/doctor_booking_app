abstract class FireStoreDataService {
  Future<void> addData({
    required String path,
    required Map<String, dynamic> data,
    String? documentId,
  });

  Future<List<Map<String, dynamic>>> getData({required String path});

  Future<Map<String, dynamic>?> getDoc({
    required String path,
    required String documentId,
  });

  Future<void> addBookedData({
    required String path,
    required Map<String, dynamic> data,
    required String documentId,
    required String secPath,
  });

  Future<List<Map<String, dynamic>>> getBookedData({
    required String path,
    required String documentId,
  });

  Future<void> updateData({
    required String path,
    required Map<String, dynamic> data,
    required String documentId,
  });
}
