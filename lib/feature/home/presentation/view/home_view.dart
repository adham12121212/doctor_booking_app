import 'package:booked_app/feature/appointment/presentation/widgets/appointment_view_body.dart';
import 'package:booked_app/feature/home/presentation/widgets/home_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/helper_functions/get_it.dart';
import '../../../appointment/presentation/view/appointment_view.dart';
import '../../../auth/logic/domain/repo/auth_repo.dart';
import '../../../auth/sigup/presentation/cubit/signup_cubit.dart';
import '../../../root/widgets/custom_navigation_bar.dart';
import '../../domain/repo/home_repo.dart';
import '../cubit/home_cubit.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});
  static const routeName = 'home';

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int currentIndex = 0;

  final List<Widget> screens = const [
    HomeViewBody(doctors: []),
    AppointmentView(),
    Center(child: Text('Settings')),
  ];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => HomeCubit(
              getIt.get<HomeRepo>(),
              getIt.get<AuthRepo>(),
            )..getDoctors(),
          ),
          BlocProvider(
            create: (context) => SignupCubit(
              getIt.get<AuthRepo>(),
            ),
          ),
        ],
        child: Scaffold(
          backgroundColor: Colors.white,
          body: IndexedStack(
            index: currentIndex,
            children: screens,
          ),
          bottomNavigationBar: CustomNavigationBar(
            currentIndex: currentIndex,
            onTap: (index) {
              setState(() {
                currentIndex = index;
              });
            },
          ),
        ),
      ),
    );
  }
}
