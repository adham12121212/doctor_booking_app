import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/app_texts.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key, required this.title, required this.showBackButton,
  });


  final String title;
  final bool showBackButton;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Visibility(
          visible: showBackButton,
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              width: 40.w,
              height: 37.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    offset: Offset(0, 1),
                    blurRadius: 1.r,
                  ),
                ],
              ),
              child: Icon(CupertinoIcons.arrow_left, size: 20,),
            ),
          ),
        ),
        SizedBox(width: 90.w),
        Text(title, style: AppTextStyles.medium20),
      ],
    );
  }
}
