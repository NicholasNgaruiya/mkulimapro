import 'package:flutter/material.dart';

import '../sasa_controller.dart';

class FeedbackManagement {
  int counter = 0;
  void verbose(String s,{required String screenContext, required String verboseType, bool persist = false}) {
    if (SasaController.IS_DEBUG_MODE) {
      print('$verboseType|$screenContext|${++counter}---$s');
    }
  }
  void showVerifyDialogue({required BuildContext context, required String email, required VoidCallback onVerifyPress, required VoidCallback onResendLink}) {

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: AlertDialog(
            title: Text('Verify Your Email'),
            content: Text('Please check your email\n$email\n and follow the instructions to verify your account.'),
            actions: <Widget>[
              TextButton(
                child: Text('Resend link'),
                onPressed: onResendLink,
              ),
              TextButton(
                child: Text('verify'),
                onPressed: onVerifyPress,
              ),
            ],
          ),
        );
      },
    );

  }
  void showUpdateDialogue({required BuildContext context, required bool mustUpdate}) {
    String updateString ='''
App Update Required
A new version of the app is available. Click update to get the latest version.
    ''';
    showDialog(
      context: context,
      barrierDismissible: !mustUpdate,
      builder: (BuildContext context) {
        return WillPopScope(
            onWillPop: () async {
              return !mustUpdate;
            },
          child: AlertDialog(
            title: Text('Notification'),
            content: Text(updateString),
            actions: <Widget>[
              TextButton(
                child: Text('Update'),
                onPressed: () async {
                  //subject to change depending on the platform
                  // const url = 'https://play.google.com/store/apps/details?id=com.codesasa.moneytrack';
                  const appId = 'com.codesasa.moneytrack'; // Replace with the actual app's ID
                  const url = 'market://details?id=$appId';
                  SasaController.utils.openUrl(url);
                },
              ),
            ],
          ),
        );
      },
    );

  }
  void showLoadingDialog(BuildContext context,{String? message}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: Dialog(
            child: Container(
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  CircularProgressIndicator(),
                  SizedBox(width: 16),
                  Text(message??"Loading..."),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
  void showRestoreDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Lost internet connection",
            style: const TextStyle(color: Colors.black87),
          ),
          content: Text(
            "Unable to fetch data from cloud!\n\nPlease check your internet connection",
            style: const TextStyle(color: Colors.black87),
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            TextButton(
              child: Text(
                "Cancel",
                style: const TextStyle(fontSize: 18),
              ),
              onPressed: () {
                Navigator.maybePop(context);
              },
            ),
          ],
        );
      },
    );
  }
}