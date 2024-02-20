import 'dart:math';

import 'package:flutter/material.dart';

import '../controllers/settings_screen_controller.dart';
import 'name_initials_avatar.dart';

class ProfileHeader extends StatelessWidget {
  final ImageProvider<Object> coverImage;
  final String title;
  final String subtitle;
  final List<Widget> actions;
  final SettingsScreenController settingsScreenController;

  const ProfileHeader(
      {Key? key,
        required this.coverImage,
        required this.title,
        required this.subtitle,
        required this.actions,
        required this.settingsScreenController
      })
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    var random = Random();
    var colorIndex = random.nextInt(100)%4;//since max limit is exclusive
    String letter = title[0].toUpperCase();
    return Stack(
      children: <Widget>[
        Ink(
          height: 200,
          decoration: BoxDecoration(
            image: DecorationImage(image: coverImage, fit: BoxFit.cover),
          ),
        ),
        Ink(
          height: 200,
          decoration: BoxDecoration(
            color: Colors.black38,
          ),
        ),
        if (actions != null)
          Container(
            width: double.infinity,
            height: 200,
            padding: const EdgeInsets.only(bottom: 0.0, right: 0.0),
            alignment: Alignment.bottomRight,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: actions,
            ),
          ),
        Container(
          width: double.infinity,
          margin: const EdgeInsets.only(top: 160),
          child: Column(
            children: <Widget>[
              NameInitialsAvatar(
                radius: 42,
                backgroundColor: Colors.white,
                borderColor: Colors.grey.shade300,
                borderWidth: 4.0,
                settingsScreenController: settingsScreenController,
                colorIndex: colorIndex,
                letter: letter,
              ),
              Text(
                title,
                style: Theme.of(context).textTheme.headline6,
              ),
              if (subtitle != null) ...[
                const SizedBox(height: 5.0),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ]
            ],
          ),
        )
      ],
    );
  }
}