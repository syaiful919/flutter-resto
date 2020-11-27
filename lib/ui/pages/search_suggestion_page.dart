import 'package:flutter/material.dart';
import 'package:resto/common/styles.dart';
import 'package:resto/data/model/restaurant_model.dart';
import 'package:resto/ui/components/search_input.dart';
import 'package:resto/ui/components/search_list_item.dart';
import 'package:resto/ui/pages/restaurant_detail_page.dart';

class SearchSuggestionPage extends StatefulWidget {
  static const routeName = '/search-suggestion';

  @override
  _SearchSuggestionPageState createState() => _SearchSuggestionPageState();
}

class _SearchSuggestionPageState extends State<SearchSuggestionPage> {
  TextEditingController searchController;
  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: SizedBox(
          height: 36,
          child: SearchInput(
            enabled: true,
            autofocus: true,
            controller: searchController,
            onChanged: (val) {
              setState(() {});
            },
            onSubmitted: (val) {},
            onClear: () {
              setState(() {
                searchController.clear();
              });
            },
          ),
        ),
      ),
      body: FutureBuilder<String>(
        future: DefaultAssetBundle.of(context)
            .loadString('assets/json/restaurants.json'),
        builder: (context, snapshot) {
          if (snapshot.data == null && searchController.text.isNotEmpty) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot?.data != null &&
              searchController.text.isNotEmpty) {
            List<RestaurantModel> restaurants =
                listRestaurantFromRawJson(snapshot.data);

            List<RestaurantModel> searched = restaurants
                .where((x) =>
                    x.name.toLowerCase().contains(searchController.text) ||
                    x.city.toLowerCase().contains(searchController.text))
                .toList();

            if (searched != null && searched.length > 0) {
              return ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(vertical: Gap.m),
                physics: NeverScrollableScrollPhysics(),
                itemCount: searched.length,
                itemBuilder: (_, index) => SearchListItem(
                  restaurant: searched[index],
                  onTap: (val) {
                    Navigator.pushNamed(
                      context,
                      RestaurantDetailPage.routeName,
                      arguments: val,
                    );
                  },
                ),
              );
            }

            return Container(
              padding: EdgeInsets.all(Gap.m),
              child: Text("Maaf, tidak ada hasil"),
            );
          }
          return Container();
        },
      ),
    );
  }
}
