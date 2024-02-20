import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:mkulimapro/global_resources/controllers/department/functions_manager.dart';
import 'package:mkulimapro/global_resources/controllers/department/security.dart';

import '../../../global_resources/controllers/sasa_controller.dart';
import '../../../global_resources/models/local_app_version.dart';
import '../../entryPoint/entry_point.dart';
import '../../onboarding/onboard_page.dart';

class LaunchScreenController {
  final screenContext = 'LaunchScreenController';
  final getPersistedUserKey = 'getPersistedUserKey';
  final persistLocalAppVersionKey = 'persistLocalAppVersionKey';
  void init({required BuildContext context, required List<CameraDescription>cameras}) {
    PouchManager().execute<void>((onSaveFunction, executeSavedFunction) {
      //save getPersisted User because its going to be used multiple times
      onSaveFunction<void>(getPersistedUserKey,({VoidCallback? onFinish}){
        SasaController.dataFlow.getPersistedUser(
            onDataSnapshot: (userAccount) /*async*/ {
              SasaController.feedbackManagement.verbose('user found: ${userAccount.userEmail}', screenContext: screenContext, verboseType: 'DEBUG');
              SasaController.controllerManagement.setUserAccount(userAccount: userAccount);
              //todo remove
              // await SasaController.sqlManagement.deleteSqlDatabase(databaseName: SasaController.dataFlow.databaseName.encode());
              // await SasaController.sqlManagement.deleteTableIfExists(databaseName: SasaController.dataFlow.databaseName.encode(), tableName: SasaController.dataFlow.SHEET_CATEGORY_TABLE.encode());
              SasaController.routeManagement.routeToScreen(
                  forgetHistory: true,
                  context: context,
                  destination: EntryPoint(userAccount: userAccount, cameras: cameras,)
              );
            },
            onNull: (errorOutput){
              SasaController.routeManagement.routeToScreen(
                  forgetHistory: true,
                  context: context,
                  destination: MPOnboardPage(cameras: cameras,)
              );
            }
        );
      });
      onSaveFunction<void>(persistLocalAppVersionKey,({VoidCallback? onFinish}){
        SasaController.dataFlow.persistLocalAppVersion(
            localAppVersion: LocalAppVersion(appVersion: SasaController.APP_VERSION),
            onSuccess: () {
              SasaController.feedbackManagement.verbose('app version persisted locally', screenContext: screenContext, verboseType: 'DEBUG');
              executeSavedFunction<void>(getPersistedUserKey);
            }
        );
      });
      SasaController.dataFlow.getLocalAppVersion(
          onDataSnapshot: (dataSnapshot) async {
            //if currentAppVersion > appVersion(stored) - delete database
            SasaController.feedbackManagement.verbose('getLocalAppVersion | dataSnapshot', screenContext: screenContext, verboseType: 'DEBUG');
            if (SasaController.APP_VERSION>dataSnapshot.appVersion) {
              SasaController.feedbackManagement.verbose('greater version found deleteing', screenContext: screenContext, verboseType: 'DEBUG');
              await SasaController.dataFlow.deleteLocalDatabase();
              executeSavedFunction<void>(persistLocalAppVersionKey);
            }
            else {
              executeSavedFunction<void>(getPersistedUserKey);
            }
          },
          onNull: (errorOutput) async {
            //delete database if exist - for users who had the app before
            await SasaController.dataFlow.deleteLocalDatabase();
            //add app version here
            SasaController.feedbackManagement.verbose('No app version found', screenContext: screenContext, verboseType: 'DEBUG');
            executeSavedFunction<void>(persistLocalAppVersionKey);
          }
      );
    });


  }
}