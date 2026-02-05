import 'package:booked_app/feature/details/presentation/view/details_view.dart';
import 'package:booked_app/feature/home/presentation/view/home_view.dart';
import 'package:booked_app/feature/splash/presentation/views/splash_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'core/helper_functions/get_it.dart';
import 'core/routing/ongenerate.dart';
import 'feature/doctor/presentation/view/doctor_view.dart';
import 'firebase_options.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Supabase.initialize(
    url: 'https://mgrwtcwcdjhazenmvosf.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im1ncnd0Y3djZGpoYXplbm12b3NmIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzAyMTUxNjUsImV4cCI6MjA4NTc5MTE2NX0.XuPUNZraVuJa4jycUVAb8MN4jJYnP0TWOPAxxUPAtDY',
  );
  setupGetIt();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        onGenerateRoute: onGenerateRoute,
        initialRoute: SplashView.routeName,
      ),
    );
  }
}

