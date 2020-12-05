import 'package:flutter/material.dart';
import 'package:resto/common/styles.dart';
import 'package:resto/data/model/restaurant_model.dart';

class SearchListItem extends StatelessWidget {
  final RestaurantModel restaurant;
  final Function(String) onTap;

  const SearchListItem({Key key, this.restaurant, this.onTap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(restaurant.id),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: Gap.m, vertical: Gap.s),
        child: Row(
          children: <Widget>[
            Icon(Icons.search),
            SizedBox(width: Gap.m),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    restaurant.name,
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  Text(
                    restaurant.city,
                    style: Theme.of(context).textTheme.caption,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
