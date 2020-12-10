import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:resto/common/config.dart';
import 'package:resto/common/styles.dart';

class RestaurantListItem extends StatelessWidget {
  final Function(String) onTap;
  final String id;
  final String name;
  final String city;
  final String pictureId;
  final double rating;

  const RestaurantListItem({
    Key key,
    this.onTap,
    this.id,
    this.name,
    this.city,
    this.pictureId,
    this.rating,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(id),
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
                BASE_IMG_SMALL + pictureId,
                width: 120,
                errorBuilder: (_, __, ___) => Container(
                  width: 120,
                  height: 75,
                  child: Icon(Icons.error),
                ),
              ),
            ),
            SizedBox(width: Gap.s),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    name,
                    key: ValueKey(id),
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  Text(
                    city,
                    style: Theme.of(context).textTheme.caption,
                  ),
                  SizedBox(height: Gap.s),
                  RatingBar.builder(
                    itemSize: 12,
                    ignoreGestures: true,
                    initialRating: rating,
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
