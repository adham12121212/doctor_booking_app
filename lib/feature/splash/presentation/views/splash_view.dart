import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/helper_functions/pref_helper.dart';
import '../../../../core/service/firebase_auth_service.dart';
import '../../../auth/login/presentation/view/login_view.dart';
import '../../../home/presentation/view/home_view.dart';
import '../../../onboarding/presentation/view/onboarding_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  static const routeName = 'splash';

  @override
  State<SplashView> createState() => _SplashViewState();
 }

  class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
   executeNavigation();
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blueColor,
      body: Center(
        child: SvgPicture.asset(
          'assets/splash_logo/Logos.svg',
          height: 80.h,
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  Future<void> executeNavigation() async {
    bool isOnboardingCompleted = await PrefHelper.getIsOnboarding();
     Future.delayed(const Duration(milliseconds: 1000), () {
       if (isOnboardingCompleted) {
         final isLoggedIn = FireBaseAuthService().isLoggedIn();
         if (isLoggedIn) {
           Navigator.pushReplacementNamed(context, HomeView.routeName);
         } else {
           Navigator.pushReplacementNamed(context, LoginView.routeName);
         }
       } else {
         Navigator.pushReplacementNamed(context, OnboardingView.routeName);
       }
     });
  }
}
