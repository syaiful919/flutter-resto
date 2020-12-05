import 'package:flutter/material.dart';
import 'package:resto/common/styles.dart';
import 'package:resto/ui/components/no_data.dart';
import 'package:resto/ui/components/restaurant_list_item.dart';
import 'package:resto/ui/components/search_input.dart';
import 'package:resto/ui/components/something_error.dart';
import 'package:resto/ui/pages/restaurant_detail_page.dart';
import 'package:resto/ui/pages/search_suggestion_page.dart';
import 'package:resto/viewmodel/home_viewmodel.dart';
import 'package:stacked/stacked.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      onModelReady: (model) => model.firstLoad(),
      viewModelBuilder: () => HomeViewModel(),
      builder: (_, model, __) => Scaffold(
        body: Builder(
          builder: (context) {
            switch (model.state) {
              case RestaurantsState.Loading:
                return Center(child: CircularProgressIndicator());
              case RestaurantsState.Error:
                return SomethingError(
                  message: model.message,
                  action: () => model.firstLoad(),
                );
              case RestaurantsState.NoData:
                return NoData();
              case RestaurantsState.HasData:
                return ListView(
                  padding: EdgeInsets.fromLTRB(Gap.m, Gap.xl, Gap.m, Gap.zero),
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
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          SearchSuggestionPage.routeName,
                        );
                      },
                      child: SearchInput(),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.only(top: Gap.l),
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: model.restaurants.length,
                      itemBuilder: (_, index) => RestaurantListItem(
                        restaurant: model.restaurants[index],
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
              default:
                return Container();
            }
          },
        ),
      ),
    );
  }
}
