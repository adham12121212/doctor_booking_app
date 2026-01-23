import 'package:flutter/material.dart';

import '../widgets/appointment_view_body.dart';

class AppointmentView extends StatelessWidget {
  const AppointmentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: const AppointmentViewBody(),
    );
  }
}
