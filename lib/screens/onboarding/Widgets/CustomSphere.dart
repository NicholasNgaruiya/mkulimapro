import 'package:flutter/material.dart';

import '../Constants/Colors.dart';

class CustomSphere extends StatelessWidget {
  final double width;
  final double height;
  const CustomSphere({
    Key? key,
    required this.width,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: this.height,
      width: this.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            circleGreenDark,
            circleGreenLight,
          ],
        ),
        shape: BoxShape.circle,
      ),
    );
  }
}
