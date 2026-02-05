// =========================
// home_repo_impl.dart  (FIX: doctors docs have uid string)
// =========================
import 'package:booked_app/feature/auth/logic/data/models/user_model.dart';
import 'package:booked_app/feature/auth/logic/domain/entity/user_entity.dart';
import 'package:booked_app/feature/home/domain/entity/doctor_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../core/constants/end_points.dart';
import '../../../../core/service/firestore_data_service.dart';
import '../../domain/repo/home_repo.dart';
import '../model/doctor_model.dart';

class HomeRepoImpl implements HomeRepo {
  final FireStoreDataService fireStoreDataService;
  HomeRepoImpl(this.fireStoreDataService);

  @override
  Future<List<DoctorEntity>> getDoctors() async {
    final data = await fireStoreDataService.getData(path: EndPoint.doctors);

    // data items include {'id': docId, ...fields}
    return data.map((e) {
      final uid = e['id'] as String; // ✅ Firestore doc id (uid)
      return DoctorModel.fromFirestore(e, uid).toEntity();
    }).toList();
  }

  @override
  Future<void> addDoctor({required DoctorEntity doctorEntity}) async{
    final uid = FirebaseAuth.instance.currentUser!.uid;
    await fireStoreDataService.addData(
          path: EndPoint.doctors,
          data: DoctorModel.fromEntity(doctorEntity).toMap(),
          documentId: uid
    );
    await fireStoreDataService.updateData(
          path: EndPoint.addUser,
          data: {'role':'doctor',
            'doctorProfileCompleted': true,},
          documentId: uid
    );

  }



}
