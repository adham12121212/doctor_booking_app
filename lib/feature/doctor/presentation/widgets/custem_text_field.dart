
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';

class CustemTextField extends StatelessWidget {
  const CustemTextField({
    super.key,
    required this.Controller,
    required this.hintText,
     this.maxLiens,
  });

  final TextEditingController Controller;
  final String hintText;
  final int? maxLiens;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLiens,
      controller: Controller,
      cursorHeight: 15.h,
      cursorColor: Colors.black,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 10.h,horizontal: 8.w),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.grey,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(
            color: Colors.grey,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(
            color: AppColors.blueColor,
          ),
        ),
      ),
    );
  }
}
