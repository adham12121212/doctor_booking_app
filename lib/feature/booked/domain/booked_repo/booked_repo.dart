
import '../entity/booked_entity.dart';

abstract class BookedRepo{
   Future<void> addBookedData({required BookedEntity entity});
   Future<void> addDoctorBookedData({required BookedEntity entity});
   Future<List<BookedEntity>> getBookedData();
}