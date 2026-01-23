import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class InActionIcons extends StatelessWidget {
  const InActionIcons({super.key, required this.image});
  final String image;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 25,
        height: 25,
        child: SvgPicture.asset(image, color: Colors.white),
      ),
    );
  }
}
