import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:resto/common/config.dart';
import 'package:resto/common/styles.dart';
import 'package:resto/viewmodel/restaurant_detail_viewmodel.dart';
import 'package:stacked/stacked.dart';

class BannerSection extends ViewModelWidget<RestaurantDetailViewModel> {
  final double radius = 32;

  @override
  Widget build(context, model) {
    return Stack(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 1,
          child: Image.network(
            BASE_IMG_LARGE + model.restaurant.pictureId,
            fit: BoxFit.cover,
          ),
        ),
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.black, Colors.transparent],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                stops: [0, 0.3],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: radius + Gap.m,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: Gap.m),
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  model.restaurant.name,
                  style: Theme.of(context)
                      .textTheme
                      .headline4
                      .copyWith(color: Colors.white),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      model.restaurant.city,
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1
                          .copyWith(color: Colors.white),
                    ),
                    RatingBar.builder(
                      unratedColor: Colors.white,
                      itemSize: 24,
                      ignoreGestures: true,
                      initialRating: model.restaurant.rating,
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
              ],
            ),
          ),
        )
      ],
    );
  }
}
