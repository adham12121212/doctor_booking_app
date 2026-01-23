abstract class FireStoreDataService{
  Future<void> addData ({required String path , required Map<String,dynamic> data , required String documentId});
  Future<void> addBookedData ({required String path , required Map<String,dynamic> data , required String documentId});
  Future<List<Map<String,dynamic>>> getData ({required String path});

}