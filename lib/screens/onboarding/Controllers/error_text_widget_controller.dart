import 'package:flutter/material.dart';

import 'onboard_page_controller.dart';

class ErrorTextWidgetController {
  String errorText = '';
  Map<String,AnimationController> animationControllers = {};
  Map<String,Animation<double>> animations = {};
  AnimationController getController({required OnboardType onboardType}) => animationControllers[onboardType.toString()]!;
  Animation<double> getAnimation({required OnboardType onboardType}) =>animations[onboardType.toString()]!;

  void initializeAnimation({required TickerProvider tickerProvider, required OnboardType onboardType}) {
    animationControllers[onboardType.toString()] = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: tickerProvider,
    )..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // Animation is completed, show the coach mark.
      }
    });
    animations[onboardType.toString()] = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: animationControllers[onboardType.toString()]!,
        curve: Curves.fastOutSlowIn,
      ),
    );
  }
  void showErrorTextWidget({required OnboardType onboardType}) {
    if (animationControllers[onboardType.toString()]!.value!=1) {
      animationControllers[onboardType.toString()]!.forward();
    }
  }
  void hideErrorTextWidget({required OnboardType onboardType}) {
    if (animationControllers[onboardType.toString()]!.value==1) {
      animationControllers[onboardType.toString()]!.reverse();
    }
  }
  void dispose({required OnboardType onboardType}) {
    animationControllers[onboardType.toString()]!.dispose();
  }
}