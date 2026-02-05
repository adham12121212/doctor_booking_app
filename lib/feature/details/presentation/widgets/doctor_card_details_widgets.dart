import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_texts.dart';
import 'doctor_image.dart';

class DoctorCardDetailsWidgets extends StatefulWidget {
  const DoctorCardDetailsWidgets({
    super.key, required this.image, required this.name, required this.speciality,
  });
  final String image;
  final String name;
  final String speciality;

  @override
  State<DoctorCardDetailsWidgets> createState() => _DoctorCardDetailsWidgetsState();
}

class _DoctorCardDetailsWidgetsState extends State<DoctorCardDetailsWidgets> {

  Future<void> makePhoneCallSafe(BuildContext context, String phoneNumber) async {
    final cleaned = phoneNumber.replaceAll(RegExp(r'[^0-9+]'), '');
    final uri = Uri(scheme: Platform.isIOS ? 'telprompt' : 'tel', path: cleaned);

    final ok = await launchUrl(uri, mode: LaunchMode.platformDefault);

    if (!ok) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Dialer not available (simulator?)')),
      );
    }
  }

  Future<void> openLocation(double lat, double lng) async {
    final Uri uri = Uri.parse(
      'https://www.google.com/maps/search/?api=1&query=$lat,$lng',
    );

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not open map';
    }
  }


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
            child: DoctorImage(
              image: widget.image,
              width: 100.w,
              height: 140.h,
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
                        widget.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.semiBold16,
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        widget.speciality,
                        style: AppTextStyles.medium14.copyWith(
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap:(){

                          makePhoneCallSafe(context,'01234567890'); // put doctor phone here
                        },
                        child: Container(
                          padding: EdgeInsets.all(10.w),
                          decoration: BoxDecoration(
                            color: AppColors.blueColor,
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                          child: Icon(Icons.phone, color: Colors.white,),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          openLocation(30.0444, 31.2357); // example: Cairo
                        },
                        child: Container(
                          padding: EdgeInsets.all(10.w),
                          decoration: BoxDecoration(
                            color: AppColors.blueColor,
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                          child: const Icon(Icons.pin_drop, color: Colors.white),
                        ),
                      ),


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
