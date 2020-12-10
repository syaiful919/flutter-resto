import 'dart:convert';
import 'dart:math';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:resto/data/model/restaurant_model.dart';
import 'package:resto/data/model/restaurants_response_model.dart';
import 'package:resto/navigation/navigation_service.dart';
import 'package:resto/navigation/router.gr.dart';
import 'package:rxdart/rxdart.dart';

final selectNotificationSubject = BehaviorSubject<String>();

class NotificationHelper {
  static NotificationHelper _instance;
  Random random = Random();
  NotificationHelper._internal() {
    _instance = this;
  }

  factory NotificationHelper() => _instance ?? NotificationHelper._internal();

  Future<void> initNotifications(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');

    var initializationSettingsIOS = IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    var initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String payload) async {
      if (payload != null) {
        print('notification payload: ' + payload);
      }
      selectNotificationSubject.add(payload);
    });
  }

  Future<void> showNotification(
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
    RestaurantsResponseModel response,
  ) async {
    var _channelId = "1";
    var _channelName = "channel_01";
    var _channelDescription = "resto channel";

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      _channelId,
      _channelName,
      _channelDescription,
      importance: Importance.Max,
      priority: Priority.High,
      ticker: 'ticker',
      styleInformation: DefaultStyleInformation(true, true),
    );

    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);

    int randomNumber = random.nextInt(response.restaurants.length);
    var titleNotification = "<b>Rekomendasi Restoran</b>";
    var restaurant = response.restaurants[randomNumber];
    var restaurantName = restaurant.name;

    await flutterLocalNotificationsPlugin.show(
      0,
      titleNotification,
      restaurantName,
      platformChannelSpecifics,
      payload: json.encode(restaurant.toJson()),
    );
  }

  void configureSelectNotificationSubject(String route) {
    selectNotificationSubject.stream.listen(
      (String payload) async {
        var data = RestaurantModel.fromJson(json.decode(payload));
        NavigationService.pushNamed(
          Routes.restaurantDetail,
          arguments: RestaurantDetailPageArguments(id: data.id),
        );
      },
    );
  }
}
