import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_texts.dart';

class DoctorCardDetailsWidgets extends StatelessWidget {
  const DoctorCardDetailsWidgets({
    super.key, required this.image, required this.name, required this.speciality,
  });
  final String image;
  final String name;
  final String speciality;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140.h,
      padding:  EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          /// Doctor image
          ClipRRect(
            borderRadius: BorderRadius.circular(14.r),
            child: Image.network(
              image,
              fit: BoxFit.cover,
              width: 100.w,
            ),
          ),
          SizedBox(width: 10.w),
          /// Doctor info
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.semiBold16,
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        speciality,
                        style: AppTextStyles.medium14.copyWith(
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        padding: EdgeInsets.all(10.w),
                        decoration: BoxDecoration(
                          color: AppColors.blueColor,
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        child: Icon(Icons.favorite_border, color: Colors.white,),
                      ),
                    ],
                  )

                ],
              ),
            ),
          ),


        ],
      ),
    );
  }
}
