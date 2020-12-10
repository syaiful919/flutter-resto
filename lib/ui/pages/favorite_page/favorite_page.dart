import 'package:flutter/material.dart';
import 'package:resto/common/styles.dart';
import 'package:resto/ui/components/no_data.dart';
import 'package:resto/ui/components/restaurant_list_item.dart';
import 'package:resto/ui/components/search_input.dart';
import 'package:resto/ui/components/something_error.dart';
import 'package:resto/viewmodel/favorite_viewmodel.dart';
import 'package:stacked/stacked.dart';

class FavoritePage extends StatefulWidget {
  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  TextEditingController _searchController;
  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FavoriteViewModel>.reactive(
      onModelReady: (model) => model.firstLoad(),
      viewModelBuilder: () => FavoriteViewModel(),
      builder: (_, model, __) => Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(
            "Restoran Favorit",
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
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
                return NoData(message: "Belum ada favorit");
              case RestaurantsState.HasData:
                return ListView(
                  padding: EdgeInsets.all(Gap.m),
                  children: <Widget>[
                    SearchInput(
                      enabled: true,
                      controller: _searchController,
                      onChanged: (val) {
                        setState(() {});
                        model.inputChanged(val);
                      },
                      onSubmitted: (val) {},
                      onClear: () {
                        setState(() {
                          _searchController.clear();
                        });
                        model.clearSearch();
                      },
                    ),
                    if (model.restaurants.length == 0)
                      Container(
                        padding: EdgeInsets.only(top: Gap.m),
                        child: Text("Tidak ada data"),
                      ),
                    if (model.restaurants.length > 0)
                      ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.only(top: Gap.l),
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: model.restaurants.length,
                        itemBuilder: (_, index) => RestaurantListItem(
                          id: model.restaurants[index].id,
                          name: model.restaurants[index].name,
                          city: model.restaurants[index].city,
                          pictureId: model.restaurants[index].pictureId,
                          rating: model.restaurants[index].rating,
                          onTap: (val) => model.goToRestaurantDetail(val),
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

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }
}
