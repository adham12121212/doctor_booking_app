import 'package:booked_app/feature/home/presentation/view/home_view.dart';
import 'package:flutter/material.dart';
import '../../feature/auth/login/presentation/view/login_view.dart';
import '../../feature/auth/sigup/presentation/view/signup_view.dart';
import '../../feature/booked/presentation/view/booked_view.dart';
import '../../feature/details/presentation/view/details_view.dart';
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
        return MaterialPageRoute(builder: (context)=> DetailsView(doctorId: settings.arguments as int));
      case   OnboardingView.routeName:
        return MaterialPageRoute(builder: (context) => const OnboardingView());
      case   BookedView.routeName:
        return MaterialPageRoute(builder: (context) =>  BookedView(doctorId: settings.arguments as int));
      default:
        return MaterialPageRoute(builder: (context) => const SplashView());
    }
}