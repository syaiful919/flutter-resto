import 'package:flutter/material.dart';

GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();

class NavigationService {
  static void pop({dynamic params}) => navigationKey.currentState.pop(params);

  static Future<dynamic> pushNamed(String routeName, {dynamic arguments}) {
    return navigationKey.currentState.pushNamed(
      routeName,
      arguments: arguments,
    );
  }
}
