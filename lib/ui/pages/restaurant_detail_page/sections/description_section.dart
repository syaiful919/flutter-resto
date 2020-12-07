import 'package:flutter/material.dart';
import 'package:resto/common/styles.dart';
import 'package:resto/ui/pages/restaurant_detail_page/local_components/menu_list.dart';
import 'package:resto/ui/pages/restaurant_detail_page/local_components/review_list.dart';
import 'package:resto/ui/pages/restaurant_detail_page/local_components/section_title.dart';
import 'package:resto/viewmodel/restaurant_detail_viewmodel.dart';
import 'package:stacked/stacked.dart';

class DescriptionSection extends ViewModelWidget<RestaurantDetailViewModel> {
  final double radius = 32;

  @override
  Widget build(context, model) {
    return Container(
      margin: EdgeInsets.only(
        top: (MediaQuery.of(context).size.width / 1) - radius,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: Gap.m,
        vertical: Gap.l,
      ),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(radius),
            topRight: Radius.circular(radius),
          )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SectionTitle(title: "Tentang"),
          Text(
            model.restaurant.description,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          SizedBox(height: Gap.l),
          MenuList(
            title: "Makanan",
            menus: model.restaurant.menus.foods,
          ),
          SizedBox(height: Gap.l),
          MenuList(
            title: "Minuman",
            menus: model.restaurant.menus.drinks,
          ),
          SizedBox(height: Gap.l),
          SectionTitle(title: "Review"),
          ReviewList(reviews: model.restaurant.customerReviews),
          Align(
            alignment: Alignment.centerRight,
            child: FlatButton(
              padding: EdgeInsets.zero,
              child: Text("Tambah Review"),
              onPressed: () => model.toogleshowReviewModal(),
            ),
          )
        ],
      ),
    );
  }
}
