import 'package:flutter/material.dart';
import 'package:resto/common/styles.dart';
import 'package:resto/ui/components/search_input.dart';
import 'package:resto/ui/pages/search_suggestion_page/local_components/search_list_item.dart';
import 'package:resto/viewmodel/search_suggestion_viewmodel.dart';
import 'package:stacked/stacked.dart';

class SearchSuggestionPage extends StatefulWidget {
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
    return ViewModelBuilder<SearchSuggestionViewModel>.reactive(
      onModelReady: (model) {},
      viewModelBuilder: () => SearchSuggestionViewModel(),
      builder: (_, model, __) => Scaffold(
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
                model.inputChanged(val);
              },
              onSubmitted: (val) {},
              onClear: () {
                setState(() {
                  searchController.clear();
                });
                model.clearSearch();
              },
            ),
          ),
        ),
        body: Builder(
          builder: (context) {
            switch (model.state) {
              case RestaurantsState.Loading:
                return Container(
                  padding: EdgeInsets.all(Gap.m),
                  alignment: Alignment.topCenter,
                  child: CircularProgressIndicator(),
                );
              case RestaurantsState.Error:
                return Container(
                  padding: EdgeInsets.all(Gap.m),
                  child: Text(model.message ?? "Maaf, terjadi kesalahan"),
                );
              case RestaurantsState.NoData:
                return Container(
                  padding: EdgeInsets.all(Gap.m),
                  child: Text("Maaf, tidak ada hasil"),
                );
              case RestaurantsState.HasData:
                return ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.symmetric(vertical: Gap.m),
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: model.restaurants.length,
                  itemBuilder: (_, index) => SearchListItem(
                    restaurant: model.restaurants[index],
                    onTap: (val) => model.goToRestaurantDetail(val),
                  ),
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
