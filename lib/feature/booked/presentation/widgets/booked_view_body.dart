import 'package:booked_app/feature/home/presentation/cubit/home_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_texts.dart';
import '../../../../core/widgets/animation_button.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../cubit/booked_cubit.dart';
import 'appointment_day_widget.dart';
import 'available_time_widget.dart';


class BookedViewBody extends StatelessWidget {
  const BookedViewBody({super.key, required this.doctorId});

  final int doctorId;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 68,left: 20,right: 20),
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
              CustomAppBar(title: 'Booked', showBackButton: true,),
              SizedBox(height: 20.h,),
              //doctor info
              Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(state.doctors[doctorId].image,
                          width: double.infinity,
                          fit: BoxFit.fitWidth,
                            height: 200.h,
                            alignment: Alignment.topCenter,
                          ),
                        ),
                        Positioned(
                          top: 160.h,
                          left: 40.w,
                          right: 40.w,
                          child: Container(
                              height: 100,
                              decoration: BoxDecoration(
                                color: AppColors.blueColor,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(state.doctors[doctorId].name,
                                    style: AppTextStyles.bold20.copyWith(color: Colors.white),),
                                  Text(state.doctors[doctorId].speciality,
                                    style: AppTextStyles.semiBold16.copyWith(color: Colors.white),),
                                ],
                              )
                          ),
                        )

                      ],
                    ),
                  ),
              SizedBox(height: 60.h,),
              Text('Appointment',style: AppTextStyles.semiBold16,),
              SizedBox(height: 10.h,),
              //appointment day
              AppointmentDayWidget(),
              SizedBox(height: 30.h,),
              //appointment time
              Text('Available Time',style: AppTextStyles.semiBold16,),
              SizedBox(height: 10.h,),
              //appointment time
              AvailableTimeWidget(),
              SizedBox(height: 20,),
              Center(
                child: AnimatedConfirmButton(
                  text: 'Confirm Booking',
                  onPressedAsync: () async {
                    await context.read<BookedCubit>().confirmBooking(state.doctors[doctorId].name);

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Booking confirmed')),
                    );
                  },
                ),
              ),






            ],
          );}
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
