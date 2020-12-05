import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:resto/common/config.dart';
import 'package:resto/common/styles.dart';
import 'package:resto/data/model/restaurant_model.dart';

class RestaurantListItem extends StatelessWidget {
  final RestaurantModel restaurant;
  final Function(String) onTap;

  const RestaurantListItem({
    Key key,
    @required this.restaurant,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(restaurant.id),
      child: Card(
        margin: EdgeInsets.only(bottom: Gap.m),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(4),
                bottomLeft: Radius.circular(4),
              ),
              child: Image.network(
                BASE_IMG_SMALL + restaurant.pictureId,
                width: 120,
              ),
            ),
            SizedBox(width: Gap.s),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    restaurant.name,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  Text(
                    restaurant.city,
                    style: Theme.of(context).textTheme.caption,
                  ),
                  SizedBox(height: Gap.s),
                  RatingBar.builder(
                    itemSize: 12,
                    ignoreGestures: true,
                    initialRating: restaurant.rating,
                    minRating: 0,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: EdgeInsets.symmetric(horizontal: Gap.zero),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {},
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
