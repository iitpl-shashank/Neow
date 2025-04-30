import 'dart:io';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:naveli_2023/ui/app/app_view.dart';
import 'package:provider/provider.dart';

import 'database/app_preferences.dart';
import 'firebase_options.dart';
import 'notification_service/notification_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AwesomeNotifications().initialize(
    'resource://drawable/ic_icon',
    [
      NotificationChannel(
        channelKey: 'basic_channel',
        channelName: 'Basic Channel',
        channelDescription: 'This is the basic notification channel',
        defaultColor: const Color(0xFF9D50DD),
        ledColor: Colors.white,
      ),
    ],
    channelGroups: [
      NotificationChannelGroup(
        channelGroupKey: 'basic_channel_group',
        channelGroupName: 'Basic Group',
      ),
    ],
  );
  Provider.debugCheckInvalidValueType = null;
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await AppPreferences.initPref();
  await Future.delayed(const Duration(milliseconds: 300));
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final firebaseApp = Firebase.app();
  final options = firebaseApp.options;
  // print('Firebase Project ID: ${options.projectId}');
  // await FirebaseAppCheck.instance.activate(
  //     androidProvider:
  //         kDebugMode ? AndroidProvider.playIntegrity : AndroidProvider.playIntegrity);
  print('Firebase Project ID: ${options.projectId}');
  await NotificationService().initService();
  // await NotificationService.initializeNotification();
  // tz.initializeTimeZones();
  HttpOverrides.global = MyHttpOverrides();
  runApp(const App());
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print(
      'Message received in background: ${message.notification?.title}, ${message.notification?.body}');
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) {
        print('Certificate: $cert');
        print('Host: $host');
        print('Port: $port');
        return true; // Allow all certificates (for debugging only)
      };
  }
}
