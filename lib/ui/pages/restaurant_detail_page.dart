import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:resto/common/styles.dart';
import 'package:resto/data/model/restaurant_model.dart';

class RestaurantDetailPage extends StatefulWidget {
  static const routeName = '/restaurant-detail';

  final RestaurantModel restaurant;

  const RestaurantDetailPage({
    Key key,
    @required this.restaurant,
  }) : super(key: key);

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
    return Scaffold(
      body: Stack(
        children: <Widget>[
          ListView(
            padding: EdgeInsets.zero,
            controller: mainScroll,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  BannerSection(
                    restaurant: widget.restaurant,
                    radius: radius,
                  ),
                  DescriptionSection(
                    radius: radius,
                    restaurant: widget.restaurant,
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
                      widget.restaurant.name,
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
          SectionTitle(title: "Makanan"),
          ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: NeverScrollableScrollPhysics(),
            itemCount: restaurant.menus.foods.length,
            itemBuilder: (context, index) => MenuListItem(
              menu: restaurant.menus.foods[index],
            ),
          ),
          SizedBox(height: Gap.m),
          SectionTitle(title: "Minuman"),
          ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: NeverScrollableScrollPhysics(),
            itemCount: restaurant.menus.drinks.length,
            itemBuilder: (context, index) => MenuListItem(
              menu: restaurant.menus.drinks[index],
            ),
          ),
        ],
      ),
    );
  }
}

class MenuListItem extends StatelessWidget {
  final MenuItemModel menu;
  const MenuListItem({
    Key key,
    @required this.menu,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        "- ${menu.name}",
        style: Theme.of(context).textTheme.bodyText2,
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;
  const SectionTitle({
    Key key,
    @required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: Gap.xxs),
      child: Text(
        title,
        style: Theme.of(context).textTheme.subtitle1,
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
            restaurant.pictureId,
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
