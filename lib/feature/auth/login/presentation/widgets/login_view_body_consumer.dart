import 'package:booked_app/feature/auth/login/presentation/cubit/login_cubit.dart';
import 'package:booked_app/feature/auth/login/presentation/widgets/login_view_body.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../../../core/widgets/custom_snack_bar.dart';
import '../../../../home/presentation/view/home_view.dart';

class LoginViewBodyConsumer extends StatelessWidget {
  const LoginViewBodyConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if(state is LoginSuccess){
          Navigator.of(context).pushReplacementNamed(HomeView.routeName);

          CustomSnackBar().successBar(context, 'Login successfully');
         }
        if(state is LoginFailure){
         CustomSnackBar().errorBar(context, state.error);
        }
      },
      builder: (context, state) {
        return  ModalProgressHUD(
            progressIndicator: const CupertinoActivityIndicator(
              color: Colors.white,
            ),
            inAsyncCall: state is LoginLoading ? true : false,
            opacity: 0.5,
            color: Colors.white,
            child: LoginViewBody());
      },
    );
  }
}
