import 'package:flutter/material.dart';

class LoaderAnimation extends StatefulWidget {
  final Color color;
  final double radius;
  final Duration duration;

  LoaderAnimation({
    this.color = Colors.blue,
    this.radius = 20.0,
    this.duration = const Duration(seconds: 1),
  });

  @override
  _LoaderAnimationState createState() => _LoaderAnimationState();
}

class _LoaderAnimationState extends State<LoaderAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..addListener(() {
      setState(() {});
    });

    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.radius * 2,
      height: widget.radius * 2,
      child: CustomPaint(
        painter: _LoaderPainter(
          color: widget.color,
          animationValue: _controller.value,
        ),
      ),
    );
  }
}

class _LoaderPainter extends CustomPainter {
  final Color color;
  final double animationValue;

  _LoaderPainter({
    required this.color,
    required this.animationValue,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.1; // Adjust the thickness of the loader

    final double angle = 2 * 3.14159 * animationValue;
    final Offset center = Offset(size.width / 2, size.height / 2);
    final double radius = size.width / 2 - paint.strokeWidth / 2;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -0.5 * 3.14159,
      angle,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
