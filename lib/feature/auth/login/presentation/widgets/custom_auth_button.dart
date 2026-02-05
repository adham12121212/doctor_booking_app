
import 'package:booked_app/core/constants/app_colors.dart';
import 'package:booked_app/core/constants/app_texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAuthButton extends StatelessWidget {
  const CustomAuthButton({
    super.key, 
    this.onTap, required this.text,
  });

    final VoidCallback? onTap;
    final String text;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 45.h,
        margin: EdgeInsets.only(top: 30.h),
        decoration: BoxDecoration(
          color: AppColors.blueColor,
          borderRadius: BorderRadius.circular(15.r),
        ),
        child: Center(
          child: Text( text,
            style: AppTextStyles.bold20.copyWith(
              color: Colors.white,
              )),
        )
      ),
    );
  }
}