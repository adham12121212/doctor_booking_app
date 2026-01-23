import 'package:booked_app/feature/details/presentation/widgets/details_view_body.dart';
import 'package:booked_app/feature/home/presentation/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/helper_functions/get_it.dart';
import '../../../auth/logic/domain/repo/auth_repo.dart';
import '../../../home/domain/repo/home_repo.dart';
import '../widgets/booked_button.dart';

class DetailsView extends StatelessWidget {
  const DetailsView({super.key, required this.doctorId});
  final int doctorId;
  static const routeName = 'details';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(
        getIt.get<HomeRepo>(),
        getIt.get<AuthRepo>(),
      )..getDoctors(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: DetailsViewBody(doctorId: doctorId),
        bottomNavigationBar:
        BookedButton(doctorId: doctorId),
      ),
    );
  }
}

