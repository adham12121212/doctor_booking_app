import 'package:booked_app/feature/settings/presentation/widgets/setting_item_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_texts.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../dashboard/presentation/view/dashboard_view.dart';
import '../../../doctor/presentation/view/doctor_view.dart';
import '../../../home/presentation/cubit/home_cubit.dart';
import '../../../home/presentation/view/home_view.dart';
import '../cubit/settings_cubit.dart';

class SettingsViewBody extends StatelessWidget {
  const SettingsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;

    return BlocListener<SettingsCubit, SettingsState>(
      listener: (context, state) {
        if (state is SettingsNeedDoctorForm) {
          Navigator.of(context).pushNamed(DoctorView.routeName);
        } else if (state is SettingsOpenDoctorHome) {
          Navigator.of(context).pushNamed(DoctorDashboard.routeName);
        } else if (state is SettingsError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 68.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: w / 6.w),
            child: CustomAppBar(title: 'Settings', showBackButton: false),
          ),
          SizedBox(height: 20.h),

          SettingItemCard(
            icon: Icons.person,
            title: 'Profile',
            routeName: HomeView.routeName,
            color: AppColors.blueColor,
            onTap: () {},
          ),
          SizedBox(height: 20.h),
          SettingItemCard(
            icon: Icons.help,
            title: 'Help',
            routeName: HomeView.routeName,
            color: AppColors.blueColor,
            onTap: () {},
          ),
          SizedBox(height: 20.h),
          SettingItemCard(
            icon: Icons.language,
            title: 'Language',
            routeName: HomeView.routeName,
            color: AppColors.blueColor,
            onTap: () {},
          ),
          SizedBox(height: 20.h),

          // ✅ Doctor Mode
          BlocBuilder<SettingsCubit, SettingsState>(
            builder: (context, state) {
              final isLoading = state is SettingsLoading;

              return GestureDetector(
                onTap: isLoading
                    ? null
                    : () => context.read<SettingsCubit>().openDoctorMode(),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40.0.w),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.r),
                      color: AppColors.blueColor.withValues(alpha: .5),
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
                              color: AppColors.blueColor.withValues(alpha: .7),
                            ),
                          ),
                          Positioned(
                            top: -30,
                            left: -150,
                            child: SvgPicture.asset(
                              'assets/test_images/Ellipse 1.svg',
                              height: 350.h,
                              width: 200.w,
                              color: AppColors.blueColor.withValues(alpha: .7),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(16.0.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (isLoading)
                                  const CupertinoActivityIndicator()
                                else
                                  Text(
                                    'Doctor Mode',
                                    style: AppTextStyles.semiBold20.copyWith(
                                      color: Colors.white,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),

          const Spacer(),
          SettingItemCard(
            icon: Icons.logout,
            title: 'Logout',
            routeName: HomeView.routeName,
            color: AppColors.redColor,
            onTap: () {
              context.read<HomeCubit>().signOut();
              Navigator.of(
                context,
              ).pushNamedAndRemoveUntil('/', (route) => false);
            },
          ),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }
}
