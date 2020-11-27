import 'package:flutter/material.dart';
import 'package:resto/common/styles.dart';
import 'package:resto/ui/pages/home_page.dart';
import 'package:resto/ui/pages/restaurant_detail_page.dart';
import 'package:resto/ui/pages/search_suggestion_page.dart';

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
      initialRoute: HomePage.routeName,
      routes: {
        HomePage.routeName: (_) => HomePage(),
        SearchSuggestionPage.routeName: (_) => SearchSuggestionPage(),
        RestaurantDetailPage.routeName: (context) => RestaurantDetailPage(
              restaurant: ModalRoute.of(context).settings.arguments,
            )
      },
    );
  }
}
