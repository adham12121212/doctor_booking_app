import 'package:booked_app/feature/auth/sigup/presentation/cubit/signup_cubit.dart';
import 'package:booked_app/feature/auth/sigup/presentation/widgets/signup_view_body.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../../../../../core/widgets/custom_snack_bar.dart';
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
          CustomSnackBar().successBar(context, 'Signup successfully');

        }
        if(state is SignupFailure){
          CustomSnackBar().errorBar(context, state.error);
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
            progressIndicator: const CupertinoActivityIndicator(
              color: Colors.white,
            ),
            inAsyncCall: state is SignupLoading ? true : false,
            opacity: 0.5,
            color: Colors.white,
            child: SignupViewBody());
      },
    );
  }
}
