
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/constants/end_points.dart';
import '../../../../core/service/firestore_data_service.dart';
import '../../domain/booked_repo/booked_repo.dart';
import '../../domain/entity/booked_entity.dart';
import '../model/booked_model.dart';

class BookedRepoImpl implements BookedRepo{
  final FireStoreDataService fireStoreDataService;

  BookedRepoImpl(this.fireStoreDataService);
  @override
  Future<void> addBookedData({required BookedEntity entity}) async {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    await fireStoreDataService.addBookedData(
      path: EndPoint.addUser,
      data: BookedModel.fromEntity(entity).toMap(),
      documentId: uid,
    );
  }

}