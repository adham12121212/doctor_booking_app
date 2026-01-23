import 'package:booked_app/feature/booked/presentation/widgets/booked_view_body.dart';
import 'package:booked_app/feature/home/presentation/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/helper_functions/get_it.dart';
import '../../../auth/logic/domain/repo/auth_repo.dart';
import '../../../home/domain/repo/home_repo.dart';
import '../../domain/booked_repo/booked_repo.dart';
import '../cubit/booked_cubit.dart';

class BookedView extends StatelessWidget {
  const BookedView({super.key, required this.doctorId});

  final int doctorId;

  static const routeName = 'booked';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: MultiBlocProvider(
        providers: [
           BlocProvider(
            create: (context) => HomeCubit(getIt.get<HomeRepo>(),getIt.get<AuthRepo>())..getDoctors(),
          ),
           BlocProvider(
            create: (context) => BookedCubit(getIt.get<BookedRepo>()),
          ),
        ],
        child: Scaffold(
          backgroundColor: Colors.white,
          body: BookedViewBody(doctorId: doctorId,),
        ),
      ),
    );
  }
}
