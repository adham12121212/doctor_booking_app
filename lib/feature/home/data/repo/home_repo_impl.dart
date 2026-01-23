
import 'package:booked_app/feature/home/domain/entity/doctor_entity.dart';

import '../../../../core/constants/end_points.dart';
import '../../../../core/service/firestore_data_service.dart';
import '../../../auth/logic/data/models/user_model.dart';
import '../../../auth/logic/domain/entity/user_entity.dart';
import '../../domain/repo/home_repo.dart';
import '../model/doctor_model.dart';

class HomeRepoImpl implements HomeRepo{
  final FireStoreDataService fireStoreDataService;
  HomeRepoImpl(this.fireStoreDataService);
  @override
  Future<List<DoctorEntity>> getDoctors() async{
    final data = await fireStoreDataService.getData(path: EndPoint.doctors);
    return data.map((e) => DoctorModel.fromJson(e).toEntity()).toList();
  }



}