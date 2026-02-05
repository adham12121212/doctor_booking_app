import 'package:booked_app/feature/home/domain/repo/home_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/helper_functions/get_it.dart';
import '../../../auth/logic/domain/repo/auth_repo.dart';
import '../../../home/presentation/cubit/home_cubit.dart';
import '../widgets/doctor_view_body.dart';

class DoctorView extends StatelessWidget {
  const DoctorView({super.key});

  static const routeName = 'doctorView';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: BlocProvider(
        create: (context) => HomeCubit(
          getIt.get<HomeRepo>(),
          getIt.get<AuthRepo>(),
        ),
        child: Scaffold(
          backgroundColor: AppColors.blueColor.withValues(alpha: .2),
          body: SafeArea(child: DoctorViewBody()),
        ),
      ),
    );
  }
}
