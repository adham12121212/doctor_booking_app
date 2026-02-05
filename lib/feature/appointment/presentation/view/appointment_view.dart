import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/helper_functions/get_it.dart';
import '../../../booked/domain/booked_repo/booked_repo.dart';
import '../../../booked/presentation/cubit/booked_cubit.dart';
import '../widgets/appointment_view_body.dart';

class AppointmentView extends StatelessWidget {
  const AppointmentView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BookedCubit(
        getIt.get<BookedRepo>(),
      )..getBookedApointment(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: const AppointmentViewBody(),
      ),
    );
  }
}


