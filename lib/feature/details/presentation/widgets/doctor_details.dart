import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_texts.dart';

class DoctorDetails extends StatelessWidget {
  const DoctorDetails({
    super.key, required this.iconPath, required this.title, required this.subtitle,
  });

  final String iconPath;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 40.w,
          height: 35.h,
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            color: AppColors.blueColor,
            borderRadius: BorderRadius.circular(15.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                offset: Offset(0, 1),
                blurRadius: 1.r,
              ),
            ],
          ),
          child: Center(
            child: SvgPicture.asset(iconPath,
              width: 20.w,
              height: 20.h,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(height: 5.h),
        Text(title, style: AppTextStyles.semiBold13),
        SizedBox(height: 2.h),
        Text(subtitle, style: AppTextStyles.regular12.copyWith(
          color: Colors.black54,
        )),
      ],
    );
  }
}
