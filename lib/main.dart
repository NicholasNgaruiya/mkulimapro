import 'dart:ui';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mkulimapro/screens/entryPoint/entry_point.dart';
import 'package:mkulimapro/screens/launch/launch_screen.dart';
import 'package:mkulimapro/screens/onboarding/onboard_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
  runApp(MyApp(
    cameras: cameras,
  ));
  // SystemChannels.lifecycle.setMessageHandler((msg) {
  //   if (msg!.contains("resume")) {
  //     _handleIncomingIntent();
  //   }
  //   String? string;
  //   return null;
  // });
}

// void _handleIncomingIntent() {
//   // Extract parameters from the intent URL
//   final Uri? intentData = Uri.tryParse(window.defaultRouteName);
//   if (intentData != null) {
//     // Extract parameters and take appropriate action
//     print("Received intent: $intentData");
//   }
// }
class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.cameras});
  final List<CameraDescription> cameras;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mkulima Pro',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFEEF1F8),
        primarySwatch: Colors.green,
        fontFamily: "Intel",
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(foregroundColor: Colors.white),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          errorStyle: TextStyle(height: 0),
          border: defaultInputBorder,
          enabledBorder: defaultInputBorder,
          focusedBorder: defaultInputBorder,
          errorBorder: defaultInputBorder,
        ),
      ),
      home: LaunchScreen(
        cameras: cameras,
      ),
    );
  }
}

const defaultInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(16)),
  borderSide: BorderSide(
    color: Color(0xFFDEE3F2),
    width: 1,
  ),
);
