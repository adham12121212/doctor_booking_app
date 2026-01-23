import 'package:booked_app/core/constants/app_colors.dart';
import 'package:booked_app/core/constants/app_texts.dart';
import 'package:booked_app/core/widgets/see_more_text.dart';
import 'package:booked_app/feature/home/presentation/cubit/home_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import 'doctor_card_details_widgets.dart';
import 'doctor_details.dart';

class DetailsViewBody extends StatelessWidget {
  const DetailsViewBody({super.key, required this.doctorId});

  final int doctorId;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 68, left: 20, right: 20),
      child: SingleChildScrollView(
        child: BlocBuilder<HomeCubit, HomeState>(
       builder: (context, state) {
         if (state is HomeLoading) {
           return Column(

             children: [
               SizedBox(height: 400,),
               const Center(child: CupertinoActivityIndicator()),
             ],
           );
         }

         if (state is HomeFailure) {
           return Center(child: Text(state.error));
         }
         if (state is HomeSuccess) {
           return Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               CustomAppBar(title: 'Doctor', showBackButton: true,),
               SizedBox(height: 32.h),
               DoctorCardDetailsWidgets(
                 image: state.doctors[doctorId].image,
                 name: state.doctors[doctorId].name,
                 speciality: state.doctors[doctorId].speciality,),
               SizedBox(height: 20.h),
               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceAround,
                 children: [
                   DoctorDetails(
                     title: state.doctors[doctorId].experienceYears.toString(),
                     subtitle: 'Years',
                     iconPath: 'assets/details_icons/exp.svg',),
                   DoctorDetails(
                       title: state.doctors[doctorId].patients.toString(),
                       subtitle: 'Patients',
                       iconPath: 'assets/details_icons/patient.svg'),
                   DoctorDetails(
                     title: state.doctors[doctorId].rating.toString(),
                     subtitle: 'Rating',
                     iconPath: 'assets/details_icons/star-fill.svg',),
                   DoctorDetails(
                     title: state.doctors[doctorId].reviews.toString(),
                     subtitle: 'Reviews',
                     iconPath: 'assets/details_icons/message fill.svg',),
                 ],
               ),
               SizedBox(height: 20.h),
               Text('About Me', style: AppTextStyles.semiBold18,),
               SizedBox(height: 10.h),
               SeeMoreText(
                   text: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'),
               SizedBox(height: 20.h),
             ],
           );
         }
         return const SizedBox.shrink();
       },
),
      ),
    );
  }
}



