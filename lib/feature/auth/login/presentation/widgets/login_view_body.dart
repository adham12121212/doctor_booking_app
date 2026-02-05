import 'package:booked_app/core/constants/app_colors.dart';
import 'package:booked_app/core/constants/app_texts.dart';
import 'package:booked_app/feature/auth/login/presentation/cubit/login_cubit.dart';
import 'package:booked_app/feature/auth/login/presentation/widgets/custom_auth_button.dart';
import 'package:booked_app/feature/auth/login/presentation/widgets/custom_text_form_field.dart';
import 'package:booked_app/feature/auth/login/presentation/widgets/password_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../sigup/presentation/view/signup_view.dart';

class LoginViewBody extends StatelessWidget {
  LoginViewBody({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  dispose(){
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0.w),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 120.h),
              SvgPicture.asset(
                '/Users/adhambassiouny/Development/projects/booked_app/assets/splash_logo/Logos.svg',
              ),
              SizedBox(height: 30.h),
              Container(
                height: 300.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white38,
                      blurRadius: 2,
                      offset: Offset(0, 5),
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 20.h),
                        // Email Text Field
                        CustomTextFormField(
                          controller: emailController,
                          hintText: 'Email Address',
                          keyboardType: TextInputType.emailAddress,
                          obscureText: false,
                          suffixIcon: Icon(
                            Icons.email_outlined,
                            color: AppColors.blueColor,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            if (!RegExp(
                              r'^[^@]+@[^@]+\.[^@]+',
                            ).hasMatch(value)) {
                              return 'Please enter a valid email address';
                            }
                            if (!value.endsWith('.com')) {
                              return 'Email must end with .com';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20.h),
                        // Password Text Field
                        PasswordTextField(controller: passwordController,),
                        SizedBox(height: 10.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'Forgot Password?',
                              style: AppTextStyles.bold13.copyWith(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        // Login Button
                        CustomAuthButton(
                          text: 'Login',
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              context.read<LoginCubit>().loginEmailAndPassword(
                                  email: emailController.text.trim(),
                                  password: passwordController.text.trim());
                            }

                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 80.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Don\'t have an account?',
                    style: AppTextStyles.bold13.copyWith(color: Colors.white),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(
                        context,
                      ).pushReplacementNamed(SignupView.routeName);
                    },
                    child: Text(
                      'Sign Up',
                      style: AppTextStyles.bold13.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
  }
}
