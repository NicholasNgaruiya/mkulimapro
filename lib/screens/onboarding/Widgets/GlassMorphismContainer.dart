import 'dart:ui';

import 'package:flutter/material.dart';

class GlassMorphismContainer extends StatelessWidget {
  final Widget child;
  final double height;
  final double? width;
  final double borderRadius;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  const GlassMorphismContainer({
    Key? key,
    required this.child,
    required this.height,
    this.width,
    this.borderRadius = 20.0,
    this.margin,
    this.padding
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(
        Radius.circular(borderRadius),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          height: this.height,
          width: this.width,
          padding: padding,
          margin: margin,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            gradient: RadialGradient(
              radius: 50,
              colors: [
                Colors.white.withOpacity(0.20),
                Colors.white.withOpacity(0.1),
              ],
            ),
          ),
          child: this.child,
        ),
      ),
    );
  }
}
