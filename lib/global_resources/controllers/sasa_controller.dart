// ignore_for_file: constant_identifier_names, curly_braces_in_flow_control_structures



import 'department/controller_management.dart';
import 'department/data_flow.dart';
import 'department/data_management.dart';
import 'department/feedback_management.dart';
import 'department/notification_management.dart';
import 'department/route_management.dart';
import 'department/security.dart';
import 'department/sqlite_management.dart';
import 'department/state_management.dart';
import 'department/utils.dart';

enum RouteHistory {fromSettings, fromSignUp, fromLogIn, fromHome, fromSecuritySetUpPin, fromInventory}
class SasaController {
  static String screenContext = 'SasaController';
  static int APP_VERSION = 0;
  static int BUILD_NUMBER = 0;
  static bool IS_DEBUG_MODE = true;
  // static ConstantVariables constantVariables = ConstantVariables();
  // static UserManifest userManifest = UserManifest();
  static FeedbackManagement feedbackManagement = FeedbackManagement();
  static StateManagement stateManagement = StateManagement();
  static DataManagement dataManagement = DataManagement();
  static DataFlow get dataFlow => DataFlow();
  static Utils utils = Utils();
  static RouteManagement routeManagement = RouteManagement();
  static SqliteController sqlManagement = SqliteController();
  static NotificationManagement notificationManagement = NotificationManagement();

  static ControllerManagement controllerManagement = ControllerManagement();
}
class ErrorOutput {
  // non existent table or empty list or bad internet connection or server error
  bool nonExistentTable = false;
  bool nonExistentDataOnUpdate = false;
  bool nonExistentDataOnCloudRequest = false;
  bool emptyList = false;
  bool badInternetConnection = false;
  bool serverError = false;
  @override
  String toString() {
    if (nonExistentTable) return 'nonExistentTable';
    else if (nonExistentDataOnUpdate) return 'nonExistentDataOnUpdate';
    else if (nonExistentDataOnCloudRequest) return 'nonExistentDataOnCloudRequest';
    else if (emptyList) return 'emptyList';
    else if (badInternetConnection) return 'badInternetConnection';
    else if (serverError) return 'serverError';
    else return 'Unknown';
  }

}
