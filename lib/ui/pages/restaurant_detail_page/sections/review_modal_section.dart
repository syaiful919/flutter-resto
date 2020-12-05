import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:resto/common/styles.dart';
import 'package:resto/viewmodel/restaurant_detail_viewmodel.dart';
import 'package:stacked/stacked.dart';

class ReviewModalSection extends ViewModelWidget<RestaurantDetailViewModel> {
  @override
  Widget build(context, model) {
    return WillPopScope(
      onWillPop: () async {
        model.toogleshowReviewModal();
        return false;
      },
      child: Stack(
        children: <Widget>[
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => model.toogleshowReviewModal(),
            child: Opacity(
              child: Container(width: double.infinity, color: Colors.black),
              opacity: 0.35,
            ),
          ),
          Center(
            child: Container(
              padding: EdgeInsets.all(Gap.m),
              width: MediaQuery.of(context).size.width - Gap.xl,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Berikan Review",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      GestureDetector(
                        child: Icon(Icons.close),
                        onTap: () => model.toogleshowReviewModal(),
                      )
                    ],
                  ),
                  SizedBox(height: Gap.l),
                  RatingBar.builder(
                    unratedColor: Colors.grey,
                    itemSize: 48,
                    ignoreGestures: true,
                    initialRating: 0,
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
                  SizedBox(height: Gap.l),
                  TextField(
                    maxLines: 4,
                    minLines: 2,
                    decoration: InputDecoration(
                      hintText: "Tulis reviewmu disini",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: secondaryColor),
                      ),
                    ),
                  ),
                  SizedBox(height: Gap.l),
                  RaisedButton(
                    onPressed: () {},
                    child: Text("Tambah Review"),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
