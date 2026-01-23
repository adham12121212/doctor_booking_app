import 'package:flutter/material.dart';
import '../domain/entity/bottom_navigation_bar_entity.dart';
import 'navigation_bar_widgets/nacigation_bar_items.dart';
import '../../../core/constants/app_colors.dart';

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 85,
      decoration: BoxDecoration(
        color: AppColors.blueColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 25,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: bottomNavigationBarEntity.asMap().entries.map((e) {
            final index = e.key;
            final item = e.value;

            return Expanded(
              flex: index == currentIndex ? 3 : 2,
              child: GestureDetector(
                onTap: () => onTap(index),
                child: NavigationBarItems(
                  isSelected: index == currentIndex,
                  bottomNavigationBarEntity: item,
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
