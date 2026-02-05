
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_texts.dart';
import '../../../booked/presentation/view/booked_view.dart';

class BookedButton extends StatelessWidget {
  const BookedButton({
    super.key, required this.doctorId,
  });
    final String doctorId;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.of(context).pushNamed(BookedView.routeName, arguments: doctorId);
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 35.0, left: 50, right: 50),
        child: Container(
          height: 40.h,
          decoration:BoxDecoration(
            color: AppColors.blueColor,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Center(child: Text('Book Appointment ',
            style: AppTextStyles.semiBold16.copyWith(color: Colors.white),)),
        ),
      ),
    );
  }
}
