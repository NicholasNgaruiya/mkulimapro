import 'package:flutter/material.dart';
import 'package:mkulimapro/screens/entryPoint/controller/side_bar_controller.dart';
import 'package:mkulimapro/screens/entryPoint/controller/widget_switch_controller.dart';
import 'package:rive/rive.dart';

import '../../../global_resources/controllers/sasa_controller.dart';

class MPEntryPointController {
  final mPWidgetSwitchController = MPWidgetSwitchController();
  final mPSideBarController = MPSideBarController();

  final homeKey = UniqueKey();
  final scanPlantKey = UniqueKey();
  final plantHomeKey = UniqueKey();
  final chatKey = UniqueKey();
  final profileKey = UniqueKey();
  final diseaseDetectionKey = UniqueKey();

  bool isSideBarOpen = false;
  late AnimationController animationController;
  late Animation<double> scalAnimation;
  late Animation<double> animation;

  late SMIBool isMenuOpenInput;
  void onMenuPress() {
    isMenuOpenInput.value = !isMenuOpenInput.value;

    if (animationController.value == 0) {
      animationController.forward();
    } else {
      animationController.reverse();
    }
    SasaController.stateManagement.setStateFromStateListener(
        statefulWidgets: [
          SasaController.stateManagement.ENTRY_POINT,
        ],
        stateTrigger: (){
          isSideBarOpen = !isSideBarOpen;
        }
    );

  }
}