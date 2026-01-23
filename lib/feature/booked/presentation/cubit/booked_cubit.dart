import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../domain/booked_repo/booked_repo.dart';
import '../../domain/entity/booked_entity.dart';

part 'booked_state.dart';

class BookedCubit extends Cubit<BookedState> {
  BookedCubit(this.bookedRepo) : super(BookedInitial());
  final BookedRepo bookedRepo;

  String? selectedDay;
  String? selectedTime;

  void selectDay(String day) {
    selectedDay = day;
  }

  void selectTime(String time) {
    selectedTime = time;
  }

  Future<void> confirmBooking(String doctorName) async {
    print('CONFIRM CLICKED');

    print('DAY = $selectedDay');
    print('TIME = $selectedTime');
    print('DOCTOR = $doctorName');

    if (selectedDay == null || selectedTime == null) {
      print('❌ DAY OR TIME IS NULL');
      emit(BookedError(message: 'Please select day and time'));
      return;
    }

    final entity = BookedEntity(
      doctorName: doctorName,
      day: selectedDay!,
      time: selectedTime!,
    );

    try {
      await bookedRepo.addBookedData(entity: entity);
      print('✅ DATA SENT TO FIREBASE');
      emit(BookedSuccess(booked: [entity]));
    } catch (e, s) {
      print('🔥 FIREBASE ERROR: $e');
      print(s);
      emit(BookedError(message: e.toString()));
    }
  }
}

