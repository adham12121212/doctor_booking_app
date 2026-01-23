import 'package:booked_app/feature/auth/sigup/presentation/cubit/signup_cubit.dart';
import 'package:booked_app/feature/auth/sigup/presentation/widgets/signup_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../../../login/presentation/view/login_view.dart';


class SignupViewBodyConsumer extends StatelessWidget {
  const SignupViewBodyConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignupCubit, SignupState>(
      listener: (context, state) {
        if(state is SignupSuccess){
          Navigator.pushReplacementNamed(
            context,
            LoginView.routeName,
          );
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Signup successfully')));
        }
        if(state is SignupFailure){
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text( state.error)));
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
            inAsyncCall: state is SignupLoading ? true : false,
            opacity: 0.5,
            color: Colors.white,
            child: SignupViewBody());
      },
    );
  }
}
