import 'package:flutter/material.dart';
import 'package:resto/common/styles.dart';
import 'package:resto/ui/components/no_data.dart';
import 'package:resto/ui/components/something_error.dart';
import 'package:resto/ui/pages/restaurant_detail_page/sections/banner_section.dart';
import 'package:resto/ui/pages/restaurant_detail_page/sections/description_section.dart';
import 'package:resto/ui/pages/restaurant_detail_page/sections/review_modal_section.dart';
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
      builder: (_, model, __) => WillPopScope(
        onWillPop: () async {
          model.goBack();
          return true;
        },
        child: Scaffold(
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
                        BannerSection(),
                        DescriptionSection(),
                        Positioned(
                          top: MediaQuery.of(context).size.width -
                              radius -
                              Gap.l,
                          right: radius,
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              boxShadow: [BoxShadow()],
                            ),
                            padding: EdgeInsets.all(Gap.xs),
                            child: IconButton(
                              padding: EdgeInsets.zero,
                              icon: Icon(
                                model.isFav
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: Colors.pinkAccent,
                                size: 36,
                              ),
                              onPressed: () => model.toogleFav(),
                            ),
                          ),
                        )
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
                        leading: IconButton(
                          icon: Icon(Icons.arrow_back),
                          onPressed: () => model.goBack(),
                        ),
                        title: Text(
                          model.restaurant?.name ?? "",
                          style: TextStyle(
                            color: Colors.black.withOpacity(appbarOpacity),
                          ),
                        ),
                        backgroundColor:
                            Colors.white.withOpacity(appbarOpacity),
                      ),
                    ),
                  ),
                ),
              ),
              if (model.showReviewModal) ReviewModalSection()
            ],
          ),
        ),
      ),
    );
  }
}
