import 'package:booked_app/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key, 
    this.hintText, 
    this.suffixIcon,
    this.keyboardType,
    this.obscureText,
     this.validator,
    required this.controller,
  });
  final String? hintText;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final bool? obscureText;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      obscureText: obscureText!,
      cursorColor: Colors.black,
      cursorHeight: 10.h,
       decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        hintText: hintText ,
        suffixIcon: suffixIcon,
        hintStyle: TextStyle(
          color: AppColors.blueColor,
          fontSize: 12.h,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.r),
          borderSide: BorderSide(
            color: AppColors.blueColor,
            width: 2,
          ),
      
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.r),
          borderSide: BorderSide(
            color: const Color.fromARGB(255, 98, 25, 20),
          ),
        ),  
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.r),
          borderSide: BorderSide(
            color: const Color.fromARGB(255, 139, 0, 0),
            width: 2,
          ),
        ),
       ),
    );
  }
}
