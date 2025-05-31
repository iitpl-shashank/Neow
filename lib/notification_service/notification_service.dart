// import 'dart:convert';
// import 'dart:developer';
//
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:timezone/timezone.dart' as tz;
// import 'package:timezone/standalone.dart' as tz;
// import '../../../utils/common_utils.dart';
// import '../../../utils/global_variables.dart';
// import '../database/app_preferences.dart';
// import '../utils/constant.dart';
//
// Future<void> handleBackgroundMessage(RemoteMessage message) async {
//   log('(handleBackground) Title: ${message.notification?.title}');
//   log('(handleBackground) Body: ${message.notification?.body}');
//   log('(handleBackground) Payload: ${message.data}');
// }
//
// class NotificationService {
//   final _firebaseMessaging = FirebaseMessaging.instance;
//   final _localNotificationsPlugin = FlutterLocalNotificationsPlugin();
//
//   Future<void> initService() async {
//     _firebaseMessaging.requestPermission();
//     final fCMToken = await _firebaseMessaging.getToken();
//     log('FCM Token :: $fCMToken');
//     if (fCMToken != null) {
//       AppPreferences.instance.setFCMToken(fCMToken);
//     }
//     initPushNotifications();
//     initLocalNotification();
//   }
//
//   Future initPushNotifications() async {
//     await FirebaseMessaging.instance
//         .setForegroundNotificationPresentationOptions(
//       alert: true,
//       badge: true,
//       sound: true,
//     );
//     FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
//     FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
//     FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
//     FirebaseMessaging.onMessage.listen(handleListenMessage);
//   }
//
//   Future initLocalNotification() async {
//     const android = AndroidInitializationSettings('@mipmap/ic_launcher');
//     const ios = DarwinInitializationSettings();
//     const setting = InitializationSettings(android: android, iOS: ios);
//     await _localNotificationsPlugin.initialize(setting,
//         onDidReceiveNotificationResponse:
//             (NotificationResponse notificationResponse) {
//       if (notificationResponse.payload != null) {
//         Map<String, dynamic> payloadMap =
//             jsonDecode(notificationResponse.payload!)['data'];
//         // redirectNotificationScreen(payload: payloadMap);
//       }
//     });
//   }
//
//   void handleMessage(RemoteMessage? message) {
//     log('(handleMessage) Title :: ${message?.notification?.title}');
//     log('(handleMessage) Body :: ${message?.notification?.body}');
//     log('(handleMessage) Payload :: ${message?.data}');
//     if (message == null) return;
//     // redirectNotificationScreen(payload: message.data);
//   }
//
//   void handleListenMessage(RemoteMessage? message) {
//     log("${message?.data ?? "--null--"}");
//     if (message == null) return;
//     final notification = message.notification;
//     if (notification == null) return;
//     _localNotificationsPlugin.show(
//       notification.hashCode,
//       notification.title,
//       notification.body,
//       const NotificationDetails(
//         android: AndroidNotificationDetails(
//           "high_importance_channel",
//           "High Importance Notifications",
//           channelDescription:
//               "This channel is used for important notifications.",
//           importance: Importance.high,
//           icon: '@mipmap/ic_launcher',
//         ),
//         iOS: DarwinNotificationDetails(
//           presentAlert: true,
//           presentBadge: true,
//           presentSound: true,
//         ),
//       ),
//       payload: jsonEncode(message.toMap()),
//     );
//   }
//
//   void handleScheduleListenMessage({
//     var id = 0,
//     var title,
//     var body,
//     var payload,
//     required DateTime scheduleTime,
//   }) {
//     _localNotificationsPlugin.zonedSchedule(
//         id,
//         title,
//         body,
//         tz.TZDateTime.from(scheduleTime, tz.local),
//         NotificationDetails(
//           android: AndroidNotificationDetails(
//             "high_importance_channel",
//             "High Importance Notifications",
//             channelDescription:
//                 "This channel is used for important notifications.",
//             importance: Importance.high,
//             icon: '@mipmap/ic_launcher',
//           ),
//           iOS: DarwinNotificationDetails(
//             presentAlert: true,
//             presentBadge: true,
//             presentSound: true,
//           ),
//         ),
//         payload: payload,
//         androidAllowWhileIdle: true,
//         uiLocalNotificationDateInterpretation:
//             UILocalNotificationDateInterpretation.absoluteTime);
//   }
// }
//
// // void redirectNotificationScreen({Map<String, dynamic>? payload}) {
// //   if (globalUserMaster == null) {
// //     Future.delayed(const Duration(seconds: 2), () {
// //       redirect(payload);
// //     });
// //   } else {
// //     redirect(payload);
// //   }
// // }
//
// // void redirect(Map<String, dynamic>? payload) {
// //   if (payload != null && payload['n_type'] != null) {
// //     String nType = payload['n_type'];
// //     if (nType == NotificationType.message) {
// //       push(ChatView(
// //         receiverId: int.parse("${payload['sender_id']}"),
// //         conversationId: int.parse("${payload['n_type_id']}"),
// //       ));
// //     } else if (nType == NotificationType.modelGetAppointRequest) {
// //       push(const AppointmentsBookingView());
// //     } else if (nType == NotificationType.modelLike ||
// //         nType == NotificationType.modelComment) {
// //       push(const ViewAllPost());
// //     } else if (nType == NotificationType.postUploadRequestToAlbum) {
// //       push(const PublicPostApprovalView());
// //     } else if (nType == NotificationType.updateRepairerOrder) {
// //       push(const ProductRepairRequestView());
// //     } else if (nType == NotificationType.updateRequestToModelStatus) {
// //       push(const ReqToModelView());
// //     } else if (nType == NotificationType.manufacturerNewOrder ||
// //         nType == NotificationType.gotNewParcelRecord) {
// //       push(const OrdersListView());
// //     }
// //   }
// // }

import 'dart:developer';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import '../database/app_preferences.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  log('(handleBackground) Title: ${message.notification?.title}');
  log('(handleBackground) Body: ${message.notification?.body}');
  log('(handleBackground) Payload: ${message.data}');
}

class NotificationService {
  final _firebaseMessaging = FirebaseMessaging.instance;
  Future<void> initService() async {
    debugPrint("initService called");
    _firebaseMessaging.requestPermission();
    debugPrint("initService called 2");
    final fCMToken = await _firebaseMessaging.getToken();
    debugPrint("initService called 3 ${fCMToken}");
    log('FCM Token :: $fCMToken');
    if (fCMToken != null) {
      await AppPreferences.instance.setFCMToken(fCMToken);
    }
    // initializeNotification();
  }

  static Future<void> initializeNotification() async {
    await AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
          channelGroupKey: 'high_importance_channel',
          channelKey: 'high_importance_channel',
          channelName: 'Basic notifications',
          channelDescription: 'Notification channel for basic tests',
          defaultColor: const Color(0xFF9D50DD),
          ledColor: Colors.white,
          importance: NotificationImportance.Max,
          channelShowBadge: true,
          onlyAlertOnce: true,
          playSound: true,
          criticalAlerts: true,
        )
      ],
      channelGroups: [
        NotificationChannelGroup(
          channelGroupKey: 'high_importance_channel_group',
          channelGroupName: 'Group 1',
        )
      ],
      debug: true,
    );

    await AwesomeNotifications().isNotificationAllowed().then(
      (isAllowed) async {
        if (!isAllowed) {
          await AwesomeNotifications().requestPermissionToSendNotifications();
        }
      },
    );

    await AwesomeNotifications().setListeners(
      onActionReceivedMethod: onActionReceivedMethod,
      onNotificationCreatedMethod: onNotificationCreatedMethod,
      onNotificationDisplayedMethod: onNotificationDisplayedMethod,
      onDismissActionReceivedMethod: onDismissActionReceivedMethod,
    );
  }

  /// Use this method to detect when a new notification or a schedule is created
  static Future<void> onNotificationCreatedMethod(
      ReceivedNotification receivedNotification) async {
    debugPrint('onNotificationCreatedMethod');
  }

  /// Use this method to detect every time that a new notification is displayed
  static Future<void> onNotificationDisplayedMethod(
      ReceivedNotification receivedNotification) async {
    debugPrint('onNotificationDisplayedMethod');
  }

  /// Use this method to detect if the user dismissed a notification
  static Future<void> onDismissActionReceivedMethod(
      ReceivedAction receivedAction) async {
    debugPrint('onDismissActionReceivedMethod');
  }

  /// Use this method to detect when the user taps on a notification or action button
  static Future<void> onActionReceivedMethod(
      ReceivedAction receivedAction) async {
    debugPrint('onActionReceivedMethod');
  }

  static Future<void> showNotification({
    required final String title,
    required final String body,
    final String? summary,
    final Map<String, String>? payload,
    final ActionType actionType = ActionType.Default,
    final NotificationLayout notificationLayout = NotificationLayout.Default,
    final NotificationCategory? category,
    final String? bigPicture,
    final List<NotificationActionButton>? actionButtons,
    final bool scheduled = false,
    final int? interval,
  }) async {
    assert(!scheduled || (scheduled && interval != null));

    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: -1,
        channelKey: 'high_importance_channel',
        title: title,
        body: body,
        actionType: actionType,
        notificationLayout: notificationLayout,
        summary: summary,
        category: category,
        payload: payload,
        bigPicture: bigPicture,
      ),
      actionButtons: actionButtons,
      schedule: scheduled
          ? NotificationInterval(
              interval: interval,
              timeZone:
                  await AwesomeNotifications().getLocalTimeZoneIdentifier(),
              preciseAlarm: true,
            )
          : null,
    );
  }
}
