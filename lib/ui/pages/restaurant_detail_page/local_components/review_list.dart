import 'package:flutter/material.dart';
import 'package:resto/common/styles.dart';
import 'package:resto/data/model/restaurant_model.dart';
import 'package:resto/ui/pages/restaurant_detail_page/local_components/section_title.dart';

class ReviewList extends StatelessWidget {
  final List<CustomerReviewModel> reviews;

  const ReviewList({
    Key key,
    this.reviews,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SectionTitle(title: "Review"),
        ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          physics: NeverScrollableScrollPhysics(),
          itemCount: reviews.length,
          itemBuilder: (context, index) => ReviewListItem(
            index: index,
            review: reviews[index],
          ),
        )
      ],
    );
  }
}

class ReviewListItem extends StatelessWidget {
  final int index;
  final CustomerReviewModel review;
  const ReviewListItem({
    Key key,
    @required this.review,
    this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: Gap.m),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: getColor(index),
                ),
                margin: EdgeInsets.only(right: Gap.s),
                alignment: Alignment.center,
                child: Text(
                  review.name[0],
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2
                      .copyWith(color: Colors.white),
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    review.name,
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  Text(
                    review.date,
                    style: Theme.of(context).textTheme.caption,
                  ),
                ],
              )
            ],
          ),
          SizedBox(height: Gap.xxs),
          Text(
            review.review,
            style: Theme.of(context).textTheme.bodyText2,
          ),
        ],
      ),
    );
  }
}

Color getColor(int index) {
  List<Color> colors = [
    Colors.red,
    Colors.blue,
    Colors.orange,
    Colors.purple,
    Colors.green,
  ];
  int newIndex = index;
  while (newIndex > colors.length - 1) {
    newIndex = newIndex - colors.length;
  }

  Color selectedColor = colors[newIndex];
  return selectedColor;
}
