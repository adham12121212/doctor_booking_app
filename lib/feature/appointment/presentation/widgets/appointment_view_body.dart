import 'package:booked_app/core/constants/app_colors.dart';
import 'package:booked_app/core/constants/app_texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/widgets/custom_app_bar.dart';

class AppointmentViewBody extends StatelessWidget {
  const AppointmentViewBody({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          SizedBox(height: 68,),
           CustomAppBar(title: 'Appointments', showBackButton: false,),
           SizedBox(height: 20.h,),
           Expanded(
             child: ListView.separated(
                 padding: EdgeInsets.zero,
                 separatorBuilder: (context,index) => SizedBox(height: 8.h,),
                 itemCount: 10,
               itemBuilder: (context, index) =>
                   Container(
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
                   ]
                 ),
                 child: ClipRRect(
                   borderRadius: BorderRadius.circular(20),
                   child: Stack(
                     children: [
                       Positioned(
                         top: -30,
                         left: -60,
                           child: SvgPicture.asset('assets/test_images/Ellipse 1.svg',
                           height: 250.h,
                           width:100.w,
                            color: AppColors.blueColor.withValues(alpha: .7),
                           )),
                       Padding(
                         padding: const EdgeInsets.all(20.0),
                         child: Row(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             Container(
                               clipBehavior: Clip.antiAlias,
                               height: 60.h,
                               width: 60.w,
                               decoration: BoxDecoration(
                                 shape: BoxShape.circle,
                                 color: Colors.white,
                               ),
                               child: Image.asset('assets/test_images/doctorImage.jpg',
                                 fit: BoxFit.cover,
                               ),
                             ),
                             SizedBox(width: 8.w,),
                             Column(
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                 Text('Dr.Abdullah yosry',
                                 style: AppTextStyles.bold20.copyWith(
                                   color: Colors.white
                                 ),),
                                 Text('Day: wed',
                                 style: AppTextStyles.semiBold16.copyWith(
                                   color: Colors.white
                                 ),),
                                 Text('Time: 10:00',style: AppTextStyles.semiBold16.copyWith(
                                     color: Colors.white
                                 ),)
                               ],
                             ),
                           ],
                         ),
                       )




                     ],
                   ),
                 ),
               ),
             ),
           ),

        ],
      ),
    );
  }
}
