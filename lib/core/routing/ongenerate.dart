import 'package:booked_app/feature/home/presentation/view/home_view.dart';
import 'package:booked_app/feature/settings/presentation/view/settings_view.dart';
import 'package:flutter/material.dart';
import '../../feature/auth/login/presentation/view/login_view.dart';
import '../../feature/auth/sigup/presentation/view/signup_view.dart';
import '../../feature/booked/presentation/view/booked_view.dart';
import '../../feature/dashboard/presentation/view/dashboard_view.dart';
import '../../feature/details/presentation/view/details_view.dart';
import '../../feature/doctor/presentation/view/doctor_view.dart';
import '../../feature/home/presentation/view/notification_view.dart';
import '../../feature/onboarding/presentation/view/onboarding_view.dart';
import '../../feature/splash/presentation/views/splash_view.dart';


Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name){
      case  SplashView.routeName:
        return MaterialPageRoute(builder: (context) => const SplashView());
      case   LoginView.routeName:
        return MaterialPageRoute(builder: (context) => const LoginView());
      case   SignupView.routeName:
        return MaterialPageRoute(builder: (context) => const SignupView());
      case   HomeView.routeName:
        return MaterialPageRoute(builder: (context)=> const HomeView());
      case   DetailsView.routeName:
        return MaterialPageRoute(builder: (context)=> DetailsView(doctorId: settings.arguments as String));
      case   OnboardingView.routeName:
        return MaterialPageRoute(builder: (context) => const OnboardingView());
      case   BookedView.routeName:
        return MaterialPageRoute(builder: (context) =>  BookedView(doctorId: settings.arguments as String ));
      case SettingsView.routeName:
        return MaterialPageRoute(builder: (context) => SettingsView());
      case DoctorView.routeName:
        return MaterialPageRoute(builder: (context) => DoctorView());
      case DoctorDashboard.routeName:
        return MaterialPageRoute(builder: (context) => DoctorDashboard());
      case NotificationView.routeName:
        return MaterialPageRoute(builder: (context) => NotificationView());
      default:
        return MaterialPageRoute(builder: (context) => const SplashView());
    }
}