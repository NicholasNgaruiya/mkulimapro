// ignore_for_file: prefer_const_constructors


import 'package:flutter/material.dart';

import '../../global_resources/models/user_account.dart';
import 'components/account_info_widget.dart';
import 'components/profile_header.dart';
import 'controllers/settings_screen_controller.dart';

List<String> images = [
  'https://firebasestorage.googleapis.com/v0/b/dl-flutter-ui-challenges.appspot.com/o/img%2F1.jpg?alt=media',
  'https://firebasestorage.googleapis.com/v0/b/dl-flutter-ui-challenges.appspot.com/o/img%2F2.jpg?alt=media',
  'https://firebasestorage.googleapis.com/v0/b/dl-flutter-ui-challenges.appspot.com/o/img%2F3.jpg?alt=media',
  'https://firebasestorage.googleapis.com/v0/b/dl-flutter-ui-challenges.appspot.com/o/img%2F4.jpg?alt=media',
  'https://firebasestorage.googleapis.com/v0/b/dl-flutter-ui-challenges.appspot.com/o/img%2F5.jpg?alt=media',
  'https://firebasestorage.googleapis.com/v0/b/dl-flutter-ui-challenges.appspot.com/o/img%2F6.jpg?alt=media',
  'https://firebasestorage.googleapis.com/v0/b/dl-flutter-ui-challenges.appspot.com/o/img%2F7.jpg?alt=media',
];
class SettingsScreen extends StatelessWidget {
  SettingsScreen({Key? key, required this.userAccount}) : super(key: key);
  final UserAccount userAccount;
  final settingsScreenController = SettingsScreenController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade100,
        extendBodyBehindAppBar: true,
        extendBody: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              ProfileHeader(
                coverImage: NetworkImage(images[1]),
                title: userAccount.firstName,
                subtitle: '',
                settingsScreenController: settingsScreenController,
                actions: <Widget>[
                  MaterialButton(
                    color: Colors.white,
                    shape: CircleBorder(),
                    elevation: 0,
                    child: Icon(Icons.edit),
                    onPressed: () {},
                  )
                ],
              ),

              const SizedBox(height: 10.0),
              AccountInfoWidget(userAccount: userAccount,),

            ],
          ),
        ));
  }
}