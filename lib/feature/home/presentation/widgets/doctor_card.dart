import 'package:booked_app/feature/details/presentation/widgets/doctor_image.dart';
import 'package:booked_app/feature/home/presentation/widgets/rating_chip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_texts.dart';
import '../../domain/entity/doctor_entity.dart';
import 'availability_badge.dart';

class DoctorCard extends StatelessWidget {
  const DoctorCard({
    super.key,
    required this.doctor,
    this.onTap,
  });

  final DoctorEntity doctor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16.r),
      onTap: onTap,
      child: Container(
        height: 95.h,
        padding:  EdgeInsets.all(8.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 10,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          children: [
            /// Doctor image
            ClipRRect(
              borderRadius: BorderRadius.circular(14.r),
              child:DoctorImage(
                  image: doctor.image,
                  width: 70,
                  height: 100)
            ),
             SizedBox(width: 10.w),
            /// Doctor info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        doctor.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.medium16,
                      ),
                       SizedBox(height: 2.h),
                      Text(
                        doctor.speciality,
                        style: AppTextStyles.regular12.copyWith(
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),

                  Row(
                    children: [
                      RatingChip(rating: doctor.rating),
                       SizedBox(width: 4.w),
                      Text(
                        '(${doctor.reviews} reviews)',
                        style: AppTextStyles.regular12.copyWith(
                          color: Colors.black38,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            /// Price + availability
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                AvailabilityBadge(isAvailable: doctor.isAvailable),
                Text(
                  '\$${doctor.price.toInt()}',
                  style: AppTextStyles.medium16.copyWith(
                    color: AppColors.blueColor,
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
