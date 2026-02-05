import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit() : super(DashboardInitial());

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> acceptDashboard({
    required DocumentReference<Map<String, dynamic>> appointmentRef,
    required Map<String, dynamic> appointmentData,
    required String doctorName,
  }) async {
    emit(DashboardActionLoading(appointmentPath: appointmentRef.path,actionType: DashboardActionType.accept));
    try {
      final patientUid = (appointmentData['patientUid'] ?? '').toString();
      if (patientUid.isEmpty) {
        throw Exception('patientUid is missing in appointment doc');
      }

      final day = (appointmentData['day'] ?? '').toString();
      final time = (appointmentData['time'] ?? '').toString();

      final notifRef = _firestore
          .collection('user')
          .doc(patientUid)
          .collection('notifications')
          .doc();

      await _firestore.runTransaction((tx) async {
        tx.update(appointmentRef, {'status': 'accepted'});
        tx.delete(appointmentRef);
        tx.set(notifRef, {
          'title': 'Appointment accepted',
          'body': 'Dr. $doctorName accepted your appointment: $day - $time',
          'createdAt': FieldValue.serverTimestamp(),
          'read': false,
        });
      });

      emit(DashboardActionSuccess(appointmentRef.path, 'accepted'));
    } on FirebaseException catch (e) {
      print('FirebaseException: ${e.code} - ${e.message}');
      emit(DashboardActionFailure(appointmentRef.path, '${e.code}: ${e.message}'));
    } catch (e) {
      print('Error: $e');
      emit(DashboardActionFailure(appointmentRef.path, e.toString()));
    }
  }

  Future<void> rejectDashboard({
    required DocumentReference<Map<String, dynamic>> appointmentRef,
    required Map<String, dynamic> appointmentData,
    required String doctorName,
  }) async {
    emit(DashboardActionLoading(appointmentPath: appointmentRef.path,actionType: DashboardActionType.reject));

    try {
      final patientUid = (appointmentData['patientUid'] ?? '').toString();
      if (patientUid.isEmpty) throw Exception('patientUid is missing');

      final day = (appointmentData['day'] ?? '').toString();
      final time = (appointmentData['time'] ?? '').toString();

      final notifRef = _firestore
          .collection('user')
          .doc(patientUid)
          .collection('notifications')
          .doc();

      await _firestore.runTransaction((tx) async {
        tx.update(appointmentRef, {'status': 'rejected'});
        tx.delete(appointmentRef);
        tx.set(notifRef, {
          'title': 'Appointment rejected',
          'body': 'Dr. $doctorName rejected your appointment: $day - $time',
          'type': 'appointment_rejected',
          'createdAt': FieldValue.serverTimestamp(),
          'read': false,
          'appointmentPath': appointmentRef.path,
          'doctorName': doctorName,
          'day': day,
          'time': time,
        });
      });

      emit(DashboardActionSuccess(appointmentRef.path, 'rejected'));
    } catch (e) {
      emit(DashboardActionFailure(appointmentRef.path, e.toString()));
    }
  }
}
