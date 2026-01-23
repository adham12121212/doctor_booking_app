import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_texts.dart';
import '../../../../core/helper_functions/pref_helper.dart';
import '../../../auth/login/presentation/view/login_view.dart';


class PageViewItem extends StatelessWidget {
  const PageViewItem({
    super.key,
    required this.title,
    required this.subtitle,
    required this.image,
     this.background,
    required this.isVisible,
  });
    final Widget title;
    final String subtitle;
    final String image;
    final String? background;
    final bool isVisible;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.45.h,
          width: double.infinity,
          child: Column(
            children: [
              isVisible? SizedBox(height: 40.h,):SizedBox(),
              isVisible? Row(
                children: [
                  TextButton(
                      onPressed: () {
                        PrefHelper.setIsOnboarding(true);
                        Navigator.of(context).pushReplacementNamed(LoginView.routeName);
                      },
                      child:  Text('Skip',
                        style: AppTextStyles.regular13.copyWith(
                        color: AppColors.greyColor
                      ),),
                    ),
                ],
              ) :SizedBox(),
              !isVisible? SizedBox(height: 40.h,):SizedBox(height: 120.h,),
              SvgPicture.asset(image),
              SvgPicture.asset(
                background??'',
                fit: BoxFit.cover,
                width: 300.w,
              ),
            ],
          ),
        ),
        title,
        SizedBox(height: 10.h),
        Padding(
          padding:  EdgeInsets.symmetric(horizontal: 37.0.w),
          child: Text(subtitle,textAlign: TextAlign.center,
          style: AppTextStyles.semiBold13.copyWith(
            color: AppColors.greyColor
          ),
          ),
        ),
      ],
    );
  }
}
