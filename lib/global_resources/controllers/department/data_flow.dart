
import 'dart:convert';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import '../../../screens/onboarding/Controllers/onboard_page_controller.dart';
import '../../../screens/onboarding/model/onboard.dart';
import '../../../screens/onboarding/onboard_page.dart';
import '../../models/local_app_version.dart';
import '../../models/user_account.dart';
import '../sasa_controller.dart';
import 'data_management.dart';

import 'package:mkulimapro/global_resources/controllers/department/security.dart';

enum UploadStatus{uploadInProgress,uploadFailed,uploadSuccessful,uploadSuccessButFailOnInsufficientFunds, isNull}
class DataFlow {
  final screenContext = 'Dataflow';
  final String databaseName = 'MkulimaProDb';
  final String LOGINS_TABLE = 'lt';
  final String APP_VERSION_TABLE = 'avt';

  void requestOnboardUser({required Onboard onboard, required ValueChanged<UserAccount> onSuccess, required ValueChanged<String> onFail}) {
    String path = '/';
    if (onboard.onboardType==OnboardType.login) {
      path = '/auth/v1/signin';
    }
    else if (onboard.onboardType==OnboardType.signUp) {
      path = '/auth/v1/signup';
    }
    SasaController.dataManagement.requestPostDataCloud<Onboard>(
        path: path,
        requestType: ClientRequestType.allowedUser,
        instance: onboard,
        onResponse: (response){
          if (response.statusCode == 200) {
            var responseBody = json.decode(response.body);
            int statusCode = responseBody['statusCode'];
            if (statusCode == 200) {
              SasaController.feedbackManagement.verbose('onSuccess| requestOnboardUser| $responseBody', screenContext: screenContext, verboseType: 'DEBUG');
              var payload = responseBody['payload'];
              var userAccount = const UserAccount(userEmail: '', firstName: '').fromMap(payload);
              persistUser(
                  userAccount: userAccount,
                  onSuccess: (){
                    onSuccess(userAccount);
                  });
            }
            else {
              SasaController.feedbackManagement.verbose('onError| requestOnboardUser| $responseBody', screenContext: screenContext, verboseType: 'DEBUG');
              onFail(responseBody['message']);
            }
          }
          else {
            SasaController.feedbackManagement.verbose('onError| requestOnboardUser', screenContext: screenContext, verboseType: 'DEBUG');
            onFail('Network Error. Please try again later');
          }
        },
        onError: () {
          SasaController.feedbackManagement.verbose('onError| requestOnboardUser', screenContext: screenContext, verboseType: 'DEBUG');
          onFail('Network Error. Please try again later');
        }
    );
  }
  void persistUser({required UserAccount userAccount, required VoidCallback onSuccess}) {
    SasaController.dataManagement.requestPostLocalData<UserAccount>(
        databaseName: databaseName.encode(),
        tableName: LOGINS_TABLE.encode(),
        instance: const UserAccount(userEmail: '', firstName: ''),
        sasaObjectsToAdd: [userAccount],
        onSuccess: onSuccess
    );
  }
  void getPersistedUser({required ValueChanged<UserAccount> onDataSnapshot, required ValueChanged<ErrorOutput> onNull}) {
    SasaController.dataManagement.requestGetLocalData<UserAccount>(
        databaseName: databaseName.encode(),
        tableName: LOGINS_TABLE.encode(),
        instance: UserAccount(userEmail: '', firstName: ''),
        where: '${'sqlId'.encode()} =?',
        whereArgs: ['1'],
        onNull: onNull,
        onSingleDataSnap: (userAccountSnap,onFinish) {
          onDataSnapshot(userAccountSnap);
        },
        onDataSnapShot: (dataSnapshot) {
          //redundant since we only need one entry
        }
    );
  }
  void onRequestResendVerificationLink({required BuildContext context,required List<CameraDescription>cameras}) {
    SasaController.sqlManagement.deleteTableIfExists(
        databaseName: databaseName.encode(),
        tableName: LOGINS_TABLE.encode()
    );
    SasaController.routeManagement.routeToScreen(
        forgetHistory: true,
        context: context,
        destination: MPOnboardPage(cameras: cameras,)
    );
  }
  void getLocalAppVersion({required ValueChanged<LocalAppVersion> onDataSnapshot, required ValueChanged<ErrorOutput> onNull}) {
    SasaController.dataManagement.requestGetLocalData<LocalAppVersion>(
        databaseName: databaseName.encode(),
        tableName: APP_VERSION_TABLE.encode(),
        instance: LocalAppVersion(appVersion: 0),
        where: '${'sqlId'.encode()} =?',
        whereArgs: ['1'],
        onNull: onNull,
        onSingleDataSnap: (localAccountVersionSnap,onFinish) {
          onDataSnapshot(localAccountVersionSnap);
        },
        onDataSnapShot: (dataSnapshot) {
          //redundant since we only need one entry
        }
    );
  }
  void persistLocalAppVersion({required LocalAppVersion localAppVersion, required VoidCallback onSuccess}) {
    SasaController.dataManagement.requestPostLocalData<LocalAppVersion>(
        databaseName: databaseName.encode(),
        tableName: APP_VERSION_TABLE.encode(),
        instance: LocalAppVersion(appVersion: 0),
        sasaObjectsToAdd: [localAppVersion],
        onSuccess: onSuccess
    );
  }
  void logoutUserLocally({required BuildContext context, required List<CameraDescription>cameras}) {
    onRequestResendVerificationLink(context: context, cameras: cameras);
  }
  Future<void> deleteLocalDatabase() async {
    await SasaController.dataManagement.requestDeleteSqlDatabase(databaseName: databaseName.encode());
    SasaController.feedbackManagement.verbose('deleteLocalDatabase | success', screenContext: screenContext, verboseType: 'DEBUG');
  }
}