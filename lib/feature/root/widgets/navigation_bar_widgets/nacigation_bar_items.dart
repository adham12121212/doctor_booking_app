import 'package:flutter/material.dart';
import '../../domain/entity/bottom_navigation_bar_entity.dart';
import 'active_icons.dart';
import 'inactive_icons.dart';

class NavigationBarItems extends StatelessWidget {
  const NavigationBarItems({
    super.key,
    required this.isSelected,
    required this.bottomNavigationBarEntity,
  });

  final bool isSelected;
  final BottomNavigationBarEntity bottomNavigationBarEntity;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      transitionBuilder: (child, animation) {
        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: animation,
            child: child,
          ),
        );
      },
      child: isSelected
          ? ActiveIcons(
        key: ValueKey("active_${bottomNavigationBarEntity.name}"),
        image: bottomNavigationBarEntity.activeImage,
        name: bottomNavigationBarEntity.name,
      )
          : InActionIcons(
        key: ValueKey("inactive_${bottomNavigationBarEntity.name}"),
        image: bottomNavigationBarEntity.inactiveImage,
      ),
    );
  }
}
