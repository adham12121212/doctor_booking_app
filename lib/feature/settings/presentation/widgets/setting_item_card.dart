
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_texts.dart';

class SettingItemCard extends StatelessWidget {
  const SettingItemCard({
    super.key, required this.icon, required this.title, required this.routeName, required this.color, this.onTap,
  });

  final IconData icon;
  final String title;
  final String routeName;
  final Color color;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 40.0.w),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            color: color.withValues(alpha: .5),
            boxShadow: [
              BoxShadow(
                color: Colors.blue.withOpacity(0.3),
                offset: const Offset(0, 5),
                blurRadius: 5.r,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.r),
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
                    color: color.withValues(alpha: .7),
                  ),
                ),
                Positioned(
                  top: -30,
                  left: -150,
                  child: SvgPicture.asset(
                    'assets/test_images/Ellipse 1.svg',
                    height: 350.h,
                    width: 200.w,
                    color: color.withValues(alpha: .7),
                  ),
                ),
                Padding(
                  padding:  EdgeInsets.all(16.0.h),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(icon,
                        color: Colors.white,
                        size: 20.h,
                      ),
                      Text(title,
                        style: AppTextStyles.semiBold20.copyWith(
                            color: Colors.white
                        ),),
                      GestureDetector(
                        onTap: onTap,
                          child: Icon(Icons.arrow_forward_ios,color: Colors.white,))
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
