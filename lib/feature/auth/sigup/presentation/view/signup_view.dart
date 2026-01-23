import 'package:booked_app/feature/auth/sigup/presentation/widgets/signup_view_body_consumer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/helper_functions/get_it.dart';
import '../../../logic/domain/repo/auth_repo.dart';
import '../cubit/signup_cubit.dart';


class SignupView extends StatelessWidget {
  const SignupView({super.key});

  static const routeName = 'signup';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignupCubit(
        getIt.get<AuthRepo>(),
      ),
      child: Scaffold(
        backgroundColor: AppColors.blueColor,
        body: SignupViewBodyConsumer(),
      ),
    );
  }
}
