import 'package:booked_app/core/constants/app_colors.dart';
import 'package:booked_app/core/constants/app_texts.dart';
import 'package:booked_app/feature/booked/domain/entity/booked_entity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../booked/presentation/cubit/booked_cubit.dart';
import 'appointment_card.dart';

class AppointmentViewBody extends StatelessWidget {
  const AppointmentViewBody({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        children: [
          SizedBox(height: 68.h,),
           CustomAppBar(title: 'Appointments', showBackButton: false,),
           SizedBox(height: 20.h,),
          Expanded(
            child: BlocBuilder<BookedCubit, BookedState>(
              builder: (context, state) {
                if (state is BookedLoading) {
                  return const Center(child: CupertinoActivityIndicator());
                }

                if (state is BookedError) {
                  return Center(child: Text(state.message));
                }

                if (state is BookedSuccess) {
                  return ListView.separated(
                    padding: EdgeInsets.only(bottom: 40.h),
                    separatorBuilder: (context, index) => SizedBox(height: 8.h),
                    itemCount: state.booked.length,
                    itemBuilder: (context, index) {
                      final item = state.booked[index];

                      return AppointmentCard(item: item);
                    },
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),

        ],
      ),
    );
  }
}

