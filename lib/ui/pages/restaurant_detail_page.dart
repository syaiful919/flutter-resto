import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:resto/common/config.dart';
import 'package:resto/common/styles.dart';
import 'package:resto/data/model/restaurant_model.dart';
import 'package:resto/ui/components/menu_list.dart';
import 'package:resto/ui/components/no_data.dart';
import 'package:resto/ui/components/something_error.dart';
import 'package:resto/viewmodel/restaurant_detail_viewmodel.dart';
import 'package:stacked/stacked.dart';

class RestaurantDetailPage extends StatefulWidget {
  final String id;

  const RestaurantDetailPage({Key key, @required this.id}) : super(key: key);

  @override
  _RestaurantDetailPageState createState() => _RestaurantDetailPageState();
}

class _RestaurantDetailPageState extends State<RestaurantDetailPage> {
  double appbarOpacity;
  ScrollController mainScroll = ScrollController();
  final double radius = 32;

  @override
  void initState() {
    super.initState();
    appbarOpacity = 0.0;
    mainScroll.addListener(() {
      changeAppbarOpacity(mainScroll.offset);
    });
  }

  void changeAppbarOpacity(double offset) {
    double limit = 100;
    if (offset >= 0 && offset <= limit) {
      setState(() {
        appbarOpacity = offset / limit;
      });
    } else if (offset > limit) {
      if (appbarOpacity != 1) {
        setState(() {
          appbarOpacity = 1;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RestaurantDetailViewModel>.reactive(
      onModelReady: (model) => model.firstLoad(widget.id),
      viewModelBuilder: () => RestaurantDetailViewModel(),
      builder: (_, model, __) => Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            if (model.state == RestaurantState.Loading)
              Center(
                child: CircularProgressIndicator(),
              ),
            if (model.state == RestaurantState.Error)
              SomethingError(
                message: model.message,
                action: () => model.firstLoad(widget.id),
              ),
            if (model.state == RestaurantState.NoData) NoData(),
            if (model.state == RestaurantState.HasData)
              ListView(
                padding: EdgeInsets.zero,
                controller: mainScroll,
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      BannerSection(
                        restaurant: model.restaurant,
                        radius: radius,
                      ),
                      DescriptionSection(
                        radius: radius,
                        restaurant: model.restaurant,
                      ),
                    ],
                  ),
                ],
              ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                color: Colors.white.withOpacity(appbarOpacity),
                child: SafeArea(
                  child: SizedBox(
                    height: AppBar().preferredSize.height,
                    child: AppBar(
                      elevation: 0,
                      title: Text(
                        model.restaurant?.name ?? "",
                        style: TextStyle(
                          color: Colors.black.withOpacity(appbarOpacity),
                        ),
                      ),
                      backgroundColor: Colors.white.withOpacity(appbarOpacity),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class DescriptionSection extends StatelessWidget {
  final double radius;
  final RestaurantModel restaurant;
  const DescriptionSection({
    Key key,
    @required this.radius,
    @required this.restaurant,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            restaurant.description,
            style: Theme.of(context).textTheme.bodyText2,
          ),
          SizedBox(height: Gap.m),
          MenuList(
            title: "Makanan",
            menus: restaurant.menus.foods,
          ),
          SizedBox(height: Gap.m),
          MenuList(
            title: "Minuman",
            menus: restaurant.menus.drinks,
          )
        ],
      ),
    );
  }
}

class BannerSection extends StatelessWidget {
  final double radius;
  final RestaurantModel restaurant;
  const BannerSection({
    Key key,
    @required this.radius,
    @required this.restaurant,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 1,
          child: Image.network(
            BASE_IMG_LARGE + restaurant.pictureId,
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
                  restaurant.name,
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
                      restaurant.city,
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1
                          .copyWith(color: Colors.white),
                    ),
                    RatingBar.builder(
                      unratedColor: Colors.white,
                      itemSize: 24,
                      ignoreGestures: true,
                      initialRating: restaurant.rating,
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
