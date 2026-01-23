import 'package:flutter/material.dart';

import '../../../../core/constants/app_texts.dart';

class AvailabilityBadge extends StatelessWidget {
  final bool isAvailable;

  const AvailabilityBadge({required this.isAvailable});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: isAvailable ? Colors.green.shade50 : Colors.red.shade50,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        isAvailable ? 'Available' : 'Busy',
        style: AppTextStyles.regular12.copyWith(
          color: isAvailable ? Colors.green : Colors.red,
        ),
      ),
    );
  }
}
