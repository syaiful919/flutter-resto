import 'dart:io';

import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:resto/common/styles.dart';
import 'package:resto/navigation/navigation_service.dart';
import 'package:resto/navigation/router.gr.dart';
import 'package:resto/utils/background_service.dart';
import 'package:resto/utils/notification_helper.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundService _service = BackgroundService();

  _service.initializeIsolate();
  if (Platform.isAndroid) await AndroidAlarmManager.initialize();
  await _notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Resto',
      theme: projectTheme,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: Router().onGenerateRoute,
      initialRoute: Routes.home,
      navigatorKey: navigationKey,
    );
  }
}
