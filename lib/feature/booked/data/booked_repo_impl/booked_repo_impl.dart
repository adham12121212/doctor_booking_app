
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
      secPath: 'booked',
      documentId: uid,
    );
  }

  @override
  Future<List<BookedEntity>> getBookedData() async{
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final data = await fireStoreDataService.getBookedData(path: EndPoint.addUser, documentId: uid);
    return data.map((e) => BookedModel.fromJson(e).toEntity()).toList();
  }

  @override
  Future<void> addDoctorBookedData({required BookedEntity entity}) async{
    await fireStoreDataService.addBookedData(
      path: EndPoint.doctors,
      data: BookedModel.fromEntity(entity).toMap(),
      secPath: 'Appointment',
      documentId: entity.doctorUid,
    );
  }

}