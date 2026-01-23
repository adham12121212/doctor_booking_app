import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_texts.dart';
import '../../../../core/helper_functions/pref_helper.dart';
import '../../../auth/login/presentation/view/login_view.dart';
import 'on_boarding_page_view.dart';

class OnboardingViewBody extends StatefulWidget {
  const OnboardingViewBody({super.key});

  @override
  State<OnboardingViewBody> createState() => _OnboardingViewBodyState();
}

class _OnboardingViewBodyState extends State<OnboardingViewBody> {

  final PageController controller = PageController();
  int currentIndex =0;

  @override
  void initState() {
    controller.addListener(() {
      currentIndex = controller.page!.round();
      setState(() {});
    });
    super.initState();
  }
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child:
        PagesView(
          controller: controller,
        )),

        DotsIndicator(
          dotsCount: 2,
          decorator: DotsDecorator(
            activeColor: currentIndex == 0? AppColors.blueColor: AppColors.greyColor,
            color: currentIndex == 0? AppColors.greyColor: AppColors.blueColor,
            size: Size(10, 10),
            activeSize: Size(20, 10),
          ),
        ),
        SizedBox(height: 30.h,),
        Visibility(
          maintainSize: true,
          maintainAnimation: true,
          maintainState: true,
          visible: currentIndex == 1?true:false,
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: 18.0.w),
            child: GestureDetector(
              onTap: (){
                PrefHelper.setIsOnboarding(true);
                Navigator.of(context).pushReplacementNamed(LoginView.routeName);
              },
              child: Container(
                height: 50.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.blueColor,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Center(
                  child: Text(
                    'Get Started',style: AppTextStyles.bold20
                      .copyWith(color: Colors.white),

                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 60.h,),
      ],

    );
  }
}

