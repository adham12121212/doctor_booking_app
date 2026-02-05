import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

import '../../../../core/constants/end_points.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(SettingsInitial());

  Future<void> openDoctorMode() async {
    emit(SettingsLoading());
    try {
      final uid = FirebaseAuth.instance.currentUser!.uid;

      final snap = await FirebaseFirestore.instance
          .collection(EndPoint.doctors)
          .doc(uid)
          .get();

      if (!snap.exists) {
        emit(SettingsNeedDoctorForm()); // first time => fill doctor data
      } else {
        emit(SettingsOpenDoctorHome()); // already doctor => open doctor home
      }
    } catch (e) {
      emit(SettingsError(e.toString()));
    }
  }
}
