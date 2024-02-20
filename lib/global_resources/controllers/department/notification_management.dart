import 'dart:typed_data';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mkulimapro/global_resources/controllers/sasa_controller.dart';

class NotificationManagement {
  static String screenContext = 'NotificationManagement';
  static late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  final int BACKGROUND_UPLOAD_DOWNLOAD_TASK = 0;
  final String SHEET_UPLOAD_CHANNEL_ID = 'SHEET_UPLOAD_CHANNEL_ID';
  final String SHEET_UPLOAD_CHANNEL_NAME = 'Sheet Upload';

  final String ACCOUNTS_UPLOAD_CHANNEL_ID = 'ACCOUNTS_UPLOAD_CHANNEL_ID';
  final String ACCOUNTS_UPLOAD_CHANNEL_NAME = 'Accounts Upload';

  final String TRANSACTIONS_UPLOAD_CHANNEL_ID = 'TRANSACTIONS_UPLOAD_CHANNEL_ID';
  final String TRANSACTIONS_UPLOAD_CHANNEL_NAME = 'Transactions Upload';

  final String NEW_SHEETS_CHANNEL_ID = 'NEW_SHEETS_CHANNEL_ID';
  final String NEW_SHEETS_CHANNEL_NAME = 'New Sheets';

  final String NEW_ACCOUNTS_CHANNEL_ID = 'NEW_ACCOUNTS_CHANNEL_ID';
  final String NEW_ACCOUNTS_CHANNEL_NAME = 'New Accounts';

  final String NEW_TRANSACTIONS_CHANNEL_ID = 'NEW_TRANSACTIONS_CHANNEL_ID';
  final String NEW_TRANSACTIONS_CHANNEL_NAME = 'New Transactions';
  int NEW_SHEETS_ID = 0;
  int NEW_ACCOUNTS_ID = 0;
  int NEW_TRANSACTIONS_ID = 0;
  static void initialize() async {
    flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    final DarwinInitializationSettings initializationSettingsDarwin =
    DarwinInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
      onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    );
    // final MacOSInitializationSettings initializationSettingsMacOS =
    // MacOSInitializationSettings(
    //     requestAlertPermission: false,
    //     requestBadgePermission: false,
    //     requestSoundPermission: false);
    final LinuxInitializationSettings initializationSettingsLinux =
    LinuxInitializationSettings(
        defaultActionName: 'Open notification');
    final InitializationSettings initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsDarwin,
        macOS: initializationSettingsDarwin,
        linux: initializationSettingsLinux);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: onDidReceiveNotificationResponse);


  }
  static void onDidReceiveNotificationResponse(NotificationResponse notificationResponse) async {
    final String? payload = notificationResponse.payload;
    if (notificationResponse.payload != null) {
      SasaController.feedbackManagement.verbose('notification payload: $payload', screenContext: screenContext, verboseType: 'DEBUG');
    }
  }

  Future<void> showNotification(int notificationId,{required String title,required String channelId, required String channelName, required String body, required String payload, bool autoCancel = false, bool ongoing = true, bool playSound = true}) async {

    // Configure the notification channel for Android
    AndroidNotificationChannel androidChannel = AndroidNotificationChannel(
      channelId,
      channelName,
      importance: Importance.high,
      playSound: false,
      enableLights: false,
      enableVibration: false,
    );

    // Create the notification channel for Android
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(androidChannel);

    // Configure the notification details
    NotificationDetails notificationDetails = NotificationDetails(
      android: AndroidNotificationDetails(
        channelId,
          channelName,
        importance: Importance.max,
        playSound: false,
        enableLights: false,
        enableVibration: false,
        ongoing: ongoing,
        autoCancel: autoCancel,
          additionalFlags: Int32List.fromList([4])
      ),
    );

    // Show the instant notification
    await flutterLocalNotificationsPlugin.show(
      notificationId,
      title,
      body,
      notificationDetails,
      payload: payload,
    );
  }
  Future<void> dismissNotification(int notificationId) async {
    SasaController.feedbackManagement.verbose('dismissing notification of Id: $notificationId', screenContext: screenContext, verboseType: 'DEBUG');
    await flutterLocalNotificationsPlugin.cancel(notificationId);
  }
  static void onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) async {
    // display a dialog with the notification details, tap ok to go to another page
    SasaController.feedbackManagement.verbose('notification payload: $payload', screenContext: screenContext, verboseType: 'DEBUG');
  }

}