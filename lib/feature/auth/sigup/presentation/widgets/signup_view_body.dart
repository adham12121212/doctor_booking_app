import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_texts.dart';
import '../../../login/presentation/view/login_view.dart';
import '../../../login/presentation/widgets/custom_auth_button.dart';
import '../../../login/presentation/widgets/custom_text_form_field.dart';
import '../../../login/presentation/widgets/password_text_field.dart';
import '../cubit/signup_cubit.dart';

class SignupViewBody extends StatelessWidget {
   SignupViewBody({super.key});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  dispose(){
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  Padding(
            padding:  EdgeInsets.symmetric(horizontal: 16.0.w),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 100.h,),
                  SvgPicture.asset('/Users/adhambassiouny/Development/projects/booked_app/assets/splash_logo/Logos.svg'),
                  SizedBox(height: 30.h,),
                  Container(
                    height: 345.h,
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
                      padding:  EdgeInsets.symmetric(horizontal: 16.w),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: 20.h,),
                            // Name Text Field
                            CustomTextFormField(
                              controller: nameController,
                              hintText: 'Name',
                              keyboardType: TextInputType.name,
                              obscureText: false,
                              suffixIcon: Icon(Icons.person, color: AppColors.blueColor,),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your name';
                                }
                                if(value.length < 3){
                                  return 'must be at least 3';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 10.h,),
                            // Email Text Field
                            CustomTextFormField(
                              controller: emailController,
                              hintText: 'Email Address',
                              keyboardType: TextInputType.emailAddress,
                              obscureText: false,
                              suffixIcon: Icon(Icons.email_outlined, color: AppColors.blueColor,) ,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your email';
                                }
                                if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                                  return 'Please enter a valid email address';
                                }
                                if (!value.endsWith('.com')) {
                                  return 'Email must end with .com';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 10.h,),
                            // Password Text Field
                            PasswordTextField(controller: passwordController,),
                            SizedBox(height: 10.h,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text('Forgot Password?',
                                  style: AppTextStyles.bold13.copyWith(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            // Login Button
                            CustomAuthButton(
                              text: 'SignUp',
                              onTap: (){
                                if (_formKey.currentState!.validate()) {
                                  context.read<SignupCubit>().createEmailAndPassword(
                                    emailController.text,
                                    passwordController.text,
                                    nameController.text,
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 80.h,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Already have an account?',
                        style: AppTextStyles.bold13.copyWith(
                          color: Colors.white,
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          Navigator.of(context).pushReplacementNamed(LoginView.routeName);
                        },
                        child: Text('Login',
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
