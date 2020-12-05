// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_route/auto_route.dart';
import 'package:resto/ui/pages/home_page.dart';
import 'package:resto/ui/pages/search_suggestion_page.dart';
import 'package:resto/ui/pages/restaurant_detail_page.dart';

abstract class Routes {
  static const home = '/';
  static const searchSuggestion = '/search-suggestion';
  static const restaurantDetail = '/restaurant-detail';
  static const all = {
    home,
    searchSuggestion,
    restaurantDetail,
  };
}

class Router extends RouterBase {
  @override
  Set<String> get allRoutes => Routes.all;

  @Deprecated('call ExtendedNavigator.ofRouter<Router>() directly')
  static ExtendedNavigatorState get navigator =>
      ExtendedNavigator.ofRouter<Router>();

  @override
  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case Routes.home:
        return MaterialPageRoute<dynamic>(
          builder: (context) => HomePage(),
          settings: settings,
        );
      case Routes.searchSuggestion:
        return MaterialPageRoute<dynamic>(
          builder: (context) => SearchSuggestionPage(),
          settings: settings,
        );
      case Routes.restaurantDetail:
        if (hasInvalidArgs<RestaurantDetailPageArguments>(args,
            isRequired: true)) {
          return misTypedArgsRoute<RestaurantDetailPageArguments>(args);
        }
        final typedArgs = args as RestaurantDetailPageArguments;
        return MaterialPageRoute<dynamic>(
          builder: (context) =>
              RestaurantDetailPage(key: typedArgs.key, id: typedArgs.id),
          settings: settings,
        );
      default:
        return unknownRoutePage(settings.name);
    }
  }
}

// *************************************************************************
// Arguments holder classes
// **************************************************************************

//RestaurantDetailPage arguments holder class
class RestaurantDetailPageArguments {
  final Key key;
  final String id;
  RestaurantDetailPageArguments({this.key, @required this.id});
}
