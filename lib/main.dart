import 'dart:io';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:naveli_2023/services/deep_link_service.dart';
import 'package:naveli_2023/ui/app/app_view.dart';
import 'package:provider/provider.dart';
import 'database/app_preferences.dart';
import 'firebase_options.dart';
import 'notification_service/notification_service.dart';

// Phone : 8595324499
// Pass: 123456

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
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  );
  await AppPreferences.initPref();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final firebaseApp = Firebase.app();
  final options = firebaseApp.options;
  print('Firebase Project ID: ${options.projectId}');
  NotificationService().initService(); // Run FCM token init in background without blocking startup
  HttpOverrides.global = MyHttpOverrides();

  final deepLinkService = DeepLinkService();
  deepLinkService.initialize();
  runApp(const App());
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
