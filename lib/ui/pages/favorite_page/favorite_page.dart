import 'package:flutter/material.dart';
import 'package:resto/viewmodel/favorite_viewmodel.dart';
import 'package:stacked/stacked.dart';

class FavoritePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FavoriteViewModel>.reactive(
      onModelReady: (model) {},
      viewModelBuilder: () => FavoriteViewModel(),
      builder: (_, model, __) => Scaffold(
        body: Container(
            alignment: Alignment.center, child: Text("Favorite page")),
      ),
    );
  }
}
