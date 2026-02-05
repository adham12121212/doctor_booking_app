import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

import '../../domain/booked_repo/booked_repo.dart';
import '../../domain/entity/booked_entity.dart';

part 'booked_state.dart';

class BookedCubit extends Cubit<BookedState> {
  BookedCubit(this.bookedRepo) : super(BookedInitial());
  final BookedRepo bookedRepo;

  String? selectedDay;
  String? selectedTime;

  void selectDay(String day) => selectedDay = day;
  void selectTime(String time) => selectedTime = time;

  Future<void> confirmBooking(String doctorName, String image, String uid) async {
    final patientUid = FirebaseAuth.instance.currentUser!.uid;
    final patientName = FirebaseAuth.instance.currentUser!.displayName;


    if (selectedDay == null || selectedTime == null) {
      emit(BookedError(message: 'Please select day and time'));
      return;
    }

    final entity = BookedEntity(
      image: image,
      doctorName: doctorName,
      patientUid: patientUid,
      doctorUid: uid,
      day: selectedDay!,
      time: selectedTime!,
      patientName: patientName!
    );
    try {
      await bookedRepo.addBookedData(entity: entity);
      await bookedRepo.addDoctorBookedData(entity: entity);
      emit(BookedSuccess(booked: [entity]));
    } catch (e) {
      emit(BookedError(message: e.toString()));
    }
  }

  Future<void> getBookedApointment() async {
    emit(BookedLoading());
    try {
      final data = await bookedRepo.getBookedData();
      emit(BookedSuccess(booked: data));
    } catch (e) {
      emit(BookedError(message: e.toString()));
    }
  }
}
