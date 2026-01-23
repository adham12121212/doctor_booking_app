import 'package:booked_app/feature/auth/login/presentation/cubit/login_cubit.dart';
import 'package:booked_app/feature/auth/login/presentation/widgets/login_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../home/presentation/view/home_view.dart';

class LoginViewBodyConsumer extends StatelessWidget {
  const LoginViewBodyConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if(state is LoginSuccess){
          Navigator.of(context).pushReplacementNamed(HomeView.routeName);
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Signup successfully')));
        }
        if(state is LoginFailure){
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text( state.error)));
        }
      },
      builder: (context, state) {
        return LoginViewBody();
      },
    );
  }
}
