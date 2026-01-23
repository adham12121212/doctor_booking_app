
import '../../../auth/logic/domain/entity/user_entity.dart';
import '../entity/doctor_entity.dart';

abstract class HomeRepo{
  Future<List<DoctorEntity>> getDoctors();
}