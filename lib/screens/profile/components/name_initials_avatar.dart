import 'package:flutter/material.dart';

import '../controllers/settings_screen_controller.dart';

class NameInitialsAvatar extends StatelessWidget {
  final Color borderColor;
  final Color? backgroundColor;
  final double radius;
  final double borderWidth;
  final int colorIndex;
  final SettingsScreenController settingsScreenController;
  final String letter;

  const NameInitialsAvatar(
      {Key? key,
        this.borderColor = Colors.grey,
        this.backgroundColor,
        this.radius = 30,
        this.borderWidth = 5,
        required this.colorIndex,
        required this.settingsScreenController,
        required this.letter
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius + borderWidth,
      backgroundColor: borderColor,
      child: CircleAvatar(
        radius: radius,
        backgroundColor: backgroundColor != null
            ? backgroundColor
            : Theme.of(context).primaryColor,
        child: Container(
          height: (radius - borderWidth)*2,
          width: (radius - borderWidth)*2,
          decoration: BoxDecoration(
              color: settingsScreenController.profileBackGroundColours[colorIndex],
              shape: BoxShape.circle,
              gradient: LinearGradient(
                  colors: [settingsScreenController.profileBackGroundColours[colorIndex].withOpacity(0.5), settingsScreenController.profileBackGroundColours[colorIndex]])
          ),
          child: Center(
            child: Text(
              letter,
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
        ),
        // CircleAvatar(
        //   radius: radius - borderWidth,
        //   backgroundImage: image,
        // ),
      ),
    );
  }
}