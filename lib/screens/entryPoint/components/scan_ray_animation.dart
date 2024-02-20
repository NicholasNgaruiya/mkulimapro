// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';


class ScanRayAnimation extends StatefulWidget {
  const ScanRayAnimation({Key? key, required this.containerHeight, required this.containerWidth}) : super(key: key);
  final double containerHeight, containerWidth;


  
  @override
  State<ScanRayAnimation> createState() => _ScanRayAnimationState();
}

class _ScanRayAnimationState extends State<ScanRayAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;
  late Animation<double> animation;

  var bound = 12.0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller =

        AnimationController(duration: const Duration(seconds: 2), vsync: this);

    animation = Tween<double>(begin: bound, end: widget.containerHeight-bound).animate(controller)

      ..addListener(() {

        setState(() {});
        if (animation.value==widget.containerHeight-bound) {
          controller.reverse();
        }
        else if (animation.value==bound) {
          controller.forward();
        }

      });

    controller.forward();

  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: widget.containerHeight,
          width: widget.containerWidth,
        ),
        Positioned(
            top: animation.value,
            child: Container(
              height: 2,
              color: Colors.red,
              margin: EdgeInsets.fromLTRB(12.0,0,12.0,0),
              width: widget.containerWidth-25,
            )
        )
      ],
    );
  }
}
