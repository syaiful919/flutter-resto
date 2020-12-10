import 'dart:isolate';

import 'dart:ui';

import 'package:resto/data/api/api_service.dart';
import 'package:resto/main.dart';
import 'package:resto/utils/notification_helper.dart';

final ReceivePort port = ReceivePort();

class BackgroundService {
  static BackgroundService _instance;
  static String _isolateName = 'isolate';
  static SendPort _uiSendPort;

  BackgroundService._internal() {
    _instance = this;
  }

  factory BackgroundService() => _instance ?? BackgroundService._internal();

  void initializeIsolate() {
    IsolateNameServer.registerPortWithName(port.sendPort, _isolateName);
  }

  static Future<void> randomRestaurantCallback() async {
    print('Alarm fired!');
    try {
      final NotificationHelper _notificationHelper = NotificationHelper();
      var result = await ApiService().restaurants();
      if (result != null && result.restaurants.length > 0) {
        await _notificationHelper.showNotification(
          flutterLocalNotificationsPlugin,
          result,
        );
      }
    } catch (e) {
      print("error: $e");
    }

    _uiSendPort ??= IsolateNameServer.lookupPortByName(_isolateName);
    _uiSendPort?.send(null);
  }

  Future<void> someTask() async {
    print('Execute some process');
  }
}
