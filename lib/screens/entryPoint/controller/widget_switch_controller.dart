import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:tunda/screens/disease_detection/presentation/screens/home_page_screen.dart';

import '../../../global_resources/models/user_account.dart';
import '../../chatbot/chatbot.dart';
import '../../home/home_screen.dart';
import '../../plant_home/plant_home_screen.dart';
import '../../profile/settings_screen.dart';
import '../scan_screen.dart';
import 'entry_point_controller.dart';

class MPWidgetSwitchController {
  late Widget lastWidget;
  Widget getWidgetSwitch({required String identifier, required List<CameraDescription>cameras, required MPEntryPointController entryPointController,required UserAccount userAccount}) {
    if (identifier=='') {}
    else if (identifier=='Home') {
      lastWidget = HomePage(key: entryPointController.homeKey,);
      return HomePage(key: entryPointController.homeKey,);
    }
    else if (identifier=='Scan') {
      lastWidget = DiseaseDetectionPage(key: entryPointController.diseaseDetectionKey,);
      return DiseaseDetectionPage(key: entryPointController.diseaseDetectionKey,);
    }
    else if (identifier=='Chat') {
      lastWidget = MPChatBot(key:entryPointController.chatKey,url: 'https://www.blackbox.ai/agent/MkulimaProfvWbqWa',);
      return MPChatBot(key:entryPointController.chatKey,url: 'https://www.blackbox.ai/agent/MkulimaProfvWbqWa',);
    }
    else if (identifier=='Profile') {
      lastWidget = SettingsScreen(key:entryPointController.profileKey,userAccount: userAccount,);
      return SettingsScreen(key:entryPointController.profileKey,userAccount: userAccount,);
    }
    return lastWidget;
  }
}