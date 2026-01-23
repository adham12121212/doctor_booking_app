import 'package:booked_app/feature/onboarding/presentation/widgets/page_view_item.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/app_texts.dart';


class PagesView extends StatelessWidget {
  const PagesView({super.key, required this.controller});
  final PageController controller;
  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: controller,
      children: [
        PageViewItem(
       isVisible: true,
      title: Text('Your Healthcare\nJourney Starts Here',
        style: AppTextStyles.semiBold24,
        textAlign: TextAlign.center,
      ),
      subtitle: 'Easily find medical facilities, book\nappointments, manage your schedule, and\ntrack your queue status all in one place',
      image:'assets/onboarding_logo/Logo Frame.svg',
     ),
        PageViewItem(
       isVisible: false,
      title: Text('Find Medical Facilities\nEasily',
        style: AppTextStyles.bold23,
        textAlign: TextAlign.center,
      ),
      subtitle: 'Discover nearby medical facilities with comprehensive details to help you choose the right care.',
      image:'assets/onboarding_logo/Logo Frame.svg',
      background: 'assets/onboarding_logo/Images.svg',
     ),

      ],
    );
  }
}
