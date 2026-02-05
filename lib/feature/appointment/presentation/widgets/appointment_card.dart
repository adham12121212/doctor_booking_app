import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_texts.dart';
import '../../../booked/domain/entity/booked_entity.dart';
import '../../../details/presentation/widgets/doctor_image.dart';

class AppointmentCard extends StatelessWidget {
  const AppointmentCard({
    super.key,
    required this.item,
  });

  final BookedEntity item;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColors.blueColor.withValues(alpha: .5),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.3),
            offset: const Offset(0, 5),
            blurRadius: 5,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              top: -20,
              left: -120,
              child: SvgPicture.asset(
                'assets/test_images/Ellipse 1.svg',
                height: 250.h,
                width: 150.w,
                color: AppColors.blueColor.withValues(alpha: .7),
              ),
            ),
            Positioned(
              top: -30,
              left: -150,
              child: SvgPicture.asset(
                'assets/test_images/Ellipse 1.svg',
                height: 350.h,
                width: 200.w,
                color: AppColors.blueColor.withValues(alpha: .7),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    clipBehavior: Clip.antiAlias,
                    height: 60.h,
                    width: 60.w,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: DoctorImage(
                        image: item.image,
                        width: 70,
                        height: 100),
                  ),
                  SizedBox(width: 8.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.doctorName,
                        style: AppTextStyles.bold20.copyWith(color: Colors.white),
                      ),
                      Text(
                        'Day: ${item.day}',
                        style: AppTextStyles.semiBold16.copyWith(color: Colors.white),
                      ),
                      Text(
                        'Time: ${item.time}',
                        style: AppTextStyles.semiBold16.copyWith(color: Colors.white),
                      ),
                    ],
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
