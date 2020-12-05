import 'package:flutter/material.dart';
import 'package:resto/common/styles.dart';
import 'package:resto/navigation/navigation_service.dart';
import 'package:resto/navigation/router.gr.dart';

void main() {
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
