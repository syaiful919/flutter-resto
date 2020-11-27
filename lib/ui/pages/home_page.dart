import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:resto/common/styles.dart';
import 'package:resto/data/model/restaurant_model.dart';
import 'package:resto/ui/components/restaurant_list_item.dart';
import 'package:resto/ui/components/search_input.dart';
import 'package:resto/ui/pages/restaurant_detail_page.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder<String>(
          future: DefaultAssetBundle.of(context)
              .loadString('assets/json/restaurants.json'),
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot?.data != null) {
              var data = jsonDecode(snapshot.data);
              List<RestaurantModel> restaurants = List<RestaurantModel>.from(
                data['restaurants'].map((x) => RestaurantModel.fromJson(x)),
              );

              return ListView(
                padding: EdgeInsets.all(Gap.m),
                children: <Widget>[
                  Text(
                    "Selamat datang",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Text(
                    "Mau makan dimana hari ini?",
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  SizedBox(height: Gap.m),
                  SearchInput(),
                  ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.only(top: Gap.l),
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: restaurants.length,
                    itemBuilder: (_, index) => RestaurantListItem(
                      restaurant: restaurants[index],
                      onTap: (val) {
                        Navigator.pushNamed(
                          context,
                          RestaurantDetailPage.routeName,
                          arguments: val,
                        );
                      },
                    ),
                  ),
                ],
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
