import 'package:booked_app/core/constants/app_colors.dart';
import 'package:booked_app/core/constants/app_texts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/dashboard_cubit.dart';


class DoctorDashboard extends StatelessWidget {
  const DoctorDashboard({super.key});
  static const routeName = 'dashboard';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DashboardCubit(),
      child: const _DoctorDashboardBody(),
    );
  }
}

class _DoctorDashboardBody extends StatelessWidget {
  const _DoctorDashboardBody();

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return const Scaffold(body: Center(child: Text('Not logged in')));
    }
    final uid = user.uid;

    final doctorDocStream = FirebaseFirestore.instance
        .collection('doctors')
        .where('uid', isEqualTo: uid)
        .limit(1)
        .snapshots();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text('Doctor Dashboard')),
      body: BlocListener<DashboardCubit, DashboardState>(
        listener: (context, state) {
          if (state is DashboardActionFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error: ${state.error}')),
            );
          }
          if (state is DashboardActionSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Done: ${state.status} ✅')),
            );
          }
        },
        child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: doctorDocStream,
          builder: (context, doctorSnap) {
            if (doctorSnap.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (doctorSnap.hasError) {
              return Center(child: Text('Doctor query error: ${doctorSnap.error}'));
            }

            final doctorDocs = doctorSnap.data?.docs ?? [];
            if (doctorDocs.isEmpty) {
              return const Center(child: Text('Doctor document not found'));
            }

            final doctorDoc = doctorDocs.first;
            final doctorDocId = doctorDoc.id;
            final doctorName =
            (doctorDoc.data()['name'] ?? doctorDoc.data()['doctorName'] ?? 'Doctor')
                .toString();

            final appointmentsStream = FirebaseFirestore.instance
                .collection('doctors')
                .doc(doctorDocId)
                .collection('Appointment').snapshots();

            return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: appointmentsStream,
              builder: (context, snap) {
                if (snap.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snap.hasError) {
                  return Center(child: Text('Appointments error: ${snap.error}'));
                }

                final docs = snap.data?.docs ?? [];
                if (docs.isEmpty) {
                  return const Center(child: Text('No appointments yet'));
                }

                return ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: docs.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, i) {
                    final doc = docs[i];
                    final data = doc.data();

                    final day = (data['day'] ?? '').toString();
                    final time = (data['time'] ?? '').toString();
                    final patientName = (data['patientName'] ?? data['patientUid'] ?? '').toString();
                    final status = (data['status'] ?? 'pending').toString();

                    return BlocBuilder<DashboardCubit, DashboardState>(
                      builder: (context, state) {
                        final isSameItem = state is DashboardActionLoading &&
                            state.appointmentPath == doc.reference.path;

                        final acceptLoading = isSameItem &&
                            (state as DashboardActionLoading).actionType == DashboardActionType.accept;

                        final rejectLoading = isSameItem &&
                            (state as DashboardActionLoading).actionType == DashboardActionType.reject;
                        return Container(
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: const [
                              BoxShadow(
                                blurRadius: 8,
                                color: Color(0x14000000),
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Appointment: $day - $time',
                                  style: const TextStyle(fontWeight: FontWeight.w600)),
                              const SizedBox(height: 6),
                              Text('Patient: $patientName'),
                              const SizedBox(height: 6),
                              Text('Status: $status'),
                              const SizedBox(height: 12),
                              Row(
                                children: [
                                  Expanded(
                              child: GestureDetector(
                              onTap: acceptLoading
                                  ? null
                                  : () {
                        context.read<DashboardCubit>().acceptDashboard(
                        appointmentRef: doc.reference,
                        appointmentData: data,
                        doctorName: doctorName,
                        );
                        },
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: AppColors.blueColor,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Center(
                              child: acceptLoading
                                  ? const CircularProgressIndicator(color: Colors.white)
                                  :  Text(
                                'Accept',
                                style: AppTextStyles.medium16.copyWith(
                                  color: Colors.white
                                ),
                              ),
                            ),
                          ),
                        ),
                        ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: rejectLoading
                                          ? null
                                          : () {
                                        context.read<DashboardCubit>().rejectDashboard(
                                          appointmentRef: doc.reference,
                                          appointmentData: data,
                                          doctorName: doctorName,
                                        );
                                      },
                                      child: Container(
                                        height: 50,
                                        decoration: BoxDecoration(
                                          color: AppColors.redColor,
                                          borderRadius: BorderRadius.circular(30),
                                        ),
                                        child: Center(
                                          child: rejectLoading
                                              ? const CircularProgressIndicator(color: Colors.white)
                                              :  Text(
                                            'Reject',
                                           style: AppTextStyles.medium16.copyWith(
                                                 color: Colors.white
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
