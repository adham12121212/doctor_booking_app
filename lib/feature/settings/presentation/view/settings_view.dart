import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/settings_cubit.dart';
import '../widgets/settings_view_body.dart';


class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  static const routeName = 'settings';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingsCubit(),
      child: Scaffold(
        body: SettingsViewBody(),
      ),
    );
  }
}
