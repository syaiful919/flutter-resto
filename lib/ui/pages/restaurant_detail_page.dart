import 'package:flutter/material.dart';
import 'package:resto/data/model/restaurant_model.dart';

class RestaurantDetailPage extends StatelessWidget {
  static const routeName = '/restaurant-detail';

  final RestaurantModel restaurant;

  const RestaurantDetailPage({
    Key key,
    @required this.restaurant,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
    );
  }
}
