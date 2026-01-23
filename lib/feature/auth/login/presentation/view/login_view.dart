import 'package:booked_app/core/constants/app_colors.dart';
import 'package:booked_app/core/helper_functions/get_it.dart';
import 'package:booked_app/feature/auth/login/presentation/cubit/login_cubit.dart';
import 'package:booked_app/feature/auth/login/presentation/widgets/login_view_body_consumer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../logic/domain/repo/auth_repo.dart';


class LoginView extends StatelessWidget {
  const LoginView({super.key});

  static const routeName = 'login';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: BlocProvider(
        create: (context) => LoginCubit(
          getIt.get<AuthRepo>(),
        ),
        child: Scaffold(
          backgroundColor: AppColors.blueColor,
          body: LoginViewBodyConsumer(),
        ),
      ),
    );
  }
}
