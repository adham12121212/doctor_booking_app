import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_texts.dart';
import '../cubit/booked_cubit.dart';

class AvailableTimeWidget extends StatefulWidget {
  const AvailableTimeWidget({super.key});

  @override
  State<AvailableTimeWidget> createState() => _AvailableTimeWidgetState();
}

class _AvailableTimeWidgetState extends State<AvailableTimeWidget> {

  final List timeList =
  [
    '9:00',
    '10:00',
    '11:00',
    '12:00'
  ];
  int selectedTimeIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
            timeList.length,
                (index) =>
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedTimeIndex = index;
                    });

                    context.read<BookedCubit>().selectTime(timeList[index]);
                  },

                  child: Container(
                    width: 74.w,
                    height: 28.h,
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    margin: EdgeInsets.symmetric(horizontal: 4.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: selectedTimeIndex == index ? AppColors.blueColor : Colors.white,
                      border: Border.all(color: AppColors.blueColor),
                    ),

                    child: Center(
                      child: Text(
                        timeList[index],
                        style: AppTextStyles.semiBold16.copyWith(color: selectedTimeIndex == index ? Colors.white : AppColors.blueColor),
                      ),
                    ),


                  ),
                )
        ),
      ),
    );
    ;
  }
}
