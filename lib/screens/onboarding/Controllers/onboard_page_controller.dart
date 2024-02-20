import 'dart:convert';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import '../../../global_resources/controllers/sasa_controller.dart';
import '../../../global_resources/models/user_account.dart';
import '../../entryPoint/entry_point.dart';
import '../../google_auth/google_auth.dart';
import '../model/onboard.dart';
import 'error_text_widget_controller.dart';
import 'login_signup_tab_controller.dart';
import 'onboard_button_controller.dart';
import 'package:http/http.dart' as http;


enum OnboardType {login, signUp, isNull}
class MPOnboardPageController {
  OnboardType onboardType = OnboardType.login;
  final mPOnboardButtonController = MPOnboardButtonController();
  final mPLoginSignupTabController = MPLoginSignupTabController();
  final errorTextWidgetController = ErrorTextWidgetController();

  final labelEmail = "Email address";
  final labelSirName = 'Sir Name';
  final labelFirstName = 'First Name';
  final labelPassword = 'Password';
  final labelConfirmPassword = 'Confirm Password';

  Map<String,String> inputData = {};
  void onOnboardPress({required MPOnboardPageController mpOnboardPageController,required ValueChanged<UserAccount> onSuccess, required VoidCallback onFail}) {
    errorTextWidgetController.hideErrorTextWidget(onboardType: onboardType);
    SasaController.stateManagement.setStateFromStateListener(
        statefulWidgets: ['${SasaController.stateManagement
            .MP_ONBOARD_BUTTON}_${onboardType.toString()}',
        ],
        stateTrigger: () {
          mpOnboardPageController.mPOnboardButtonController.isPressed = true;
        } //
    );
    SasaController.dataFlow.requestOnboardUser(
        onboard: Onboard(
          userEmail: inputData[labelEmail]!,
          userPassword: inputData[labelPassword]!,
          sirName: inputData[labelSirName],
          firstName: inputData[labelFirstName],
          onboardType: onboardType,
        ),
        onSuccess: (userAccount) {
          SasaController.feedbackManagement.verbose('user onboarded successfully: ${userAccount.userEmail}', screenContext: toString(), verboseType: 'DEBUG');
          SasaController.stateManagement.setStateFromStateListener(
              statefulWidgets: ['${SasaController.stateManagement
                  .MP_ONBOARD_BUTTON}_${onboardType.toString()}',
              ],
              stateTrigger: () {
                mpOnboardPageController.mPOnboardButtonController.isPressed = false;
              } //
          );
          onSuccess(userAccount);
        },
        onFail: (errorMessage){
          SasaController.feedbackManagement.verbose('user onboarded FAIL', screenContext: toString(), verboseType: 'DEBUG');
          SasaController.stateManagement.setStateFromStateListener(
              statefulWidgets: ['${SasaController.stateManagement
                  .ERROR_TEXT_WIDGET}_${onboardType.toString()}',
              ],
              stateTrigger: () {
                errorTextWidgetController.errorText = errorMessage;
              } //
          );
          SasaController.stateManagement.setStateFromStateListener(
              statefulWidgets: ['${SasaController.stateManagement
                  .MP_ONBOARD_BUTTON}_${onboardType.toString()}',
              ],
              stateTrigger: () {
                mpOnboardPageController.mPOnboardButtonController.isPressed = false;
              } //
          );
          errorTextWidgetController.showErrorTextWidget(onboardType: onboardType);
          onFail();
        }
    );
  }
  void proceedToHome({required BuildContext context, required UserAccount userAccount, required List<CameraDescription>cameras}) {
    SasaController.routeManagement.routeToScreen(
        forgetHistory: true,
        context: context,
        destination: EntryPoint(userAccount: userAccount, cameras: cameras,)
    );
  }
  void signInWithGoogle({required BuildContext context}) async {
    try {
      // Step 1: Get Google Sign-In credentials
      final googleSignInResponse = await http.get(Uri.parse('https://accounts.google.com/.well-known/openid-configuration'));
      final googleSignInConfig = json.decode(googleSignInResponse.body);

      final redirectUri = Uri.parse('${SasaController.dataManagement.endPointUrl}/oauth2redirect');
      final authEndpoint = googleSignInConfig['authorization_endpoint'];
      final clientId = '55724775338-l8u1nok2p7scap4tijcn3r38cdi0dpfi.apps.googleusercontent.com';

      final signInUrl = '$authEndpoint?response_type=code&client_id=$clientId&redirect_uri=$redirectUri&scope=openid%20email%20profile';
      SasaController.feedbackManagement.verbose('signInUrl: $signInUrl', screenContext: toString(), verboseType: 'DEBUG');
      await SasaController.utils.openUrl(signInUrl);
      // SasaController.routeManagement.routeToScreen(
      //     // forgetHistory: true,
      //     context: context,
      //     destination: MPGoogleAuth(url: signInUrl,)
      // );

      /// Open signInUrl in a WebView or in an external browser
      /// Capture the authorization code from the redirected URI

      /// Step 2: Exchange authorization code for tokens

      // final tokenEndpoint = googleSignInConfig['token_endpoint'];
      // final tokenResponse = await http.post(tokenEndpoint, body: {
      //   'code': 'AUTHORIZATION_CODE',
      //   'client_id': clientId,
      //   'redirect_uri': redirectUri.toString(),
      //   'grant_type': 'authorization_code',
      // });

      // final tokenData = json.decode(tokenResponse.body);
      //
      // // Step 3: Authenticate with Firebase using tokens
      // final firebaseResponse = await http.post(
      //     Uri.parse('https://identitytoolkit.googleapis.com/v1/accounts:signInWithIdp?key=YOUR_FIREBASE_API_KEY'),
      //   body: json.encode({
      //     'postBody': 'id_token=${tokenData['id_token']}&providerId=google.com',
      //     'requestUri': 'http://localhost',
      //     'returnIdpCredential': true,
      //     'returnSecureToken': true,
      //   }),
      // );

      // final firebaseData = json.decode(firebaseResponse.body);
      // final firebaseIdToken = firebaseData['idToken'];

      // return 'carpe diem';
    } catch (error) {
      print(error);
      // return 'null';
    }
  }

}