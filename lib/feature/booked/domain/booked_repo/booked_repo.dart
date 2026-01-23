
import '../entity/booked_entity.dart';

abstract class BookedRepo{
   Future<void> addBookedData({required BookedEntity entity});
}