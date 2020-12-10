import 'package:flutter/material.dart';
import 'package:resto/common/styles.dart';
import 'package:resto/navigation/router.gr.dart';
import 'package:resto/ui/components/no_data.dart';
import 'package:resto/ui/pages/home_page/local_components/home_fab.dart';
import 'package:resto/ui/components/restaurant_list_item.dart';
import 'package:resto/ui/components/search_input.dart';
import 'package:resto/ui/components/something_error.dart';
import 'package:resto/utils/background_service.dart';
import 'package:resto/utils/notification_helper.dart';
import 'package:resto/viewmodel/home_viewmodel.dart';
import 'package:stacked/stacked.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundService _service = BackgroundService();
  AnimationController animationController;
  Animation searchAnimation;
  Animation favAnimation;
  Animation settingAnimation;
  Animation rotationAnimation;

  @override
  void initState() {
    super.initState();
    port.listen((_) async => await _service.someTask());
    _notificationHelper
        .configureSelectNotificationSubject(Routes.restaurantDetail);
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 250),
    );
    searchAnimation = TweenSequence([
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 0.0, end: 1.2),
        weight: 75.0,
      ),
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 1.2, end: 1.0),
        weight: 25.0,
      ),
    ]).animate(animationController);
    favAnimation = TweenSequence([
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 0.0, end: 1.4),
        weight: 55.0,
      ),
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 1.4, end: 1.0),
        weight: 45.0,
      ),
    ]).animate(animationController);
    settingAnimation = TweenSequence([
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 0.0, end: 1.75),
        weight: 35.0,
      ),
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 1.75, end: 1.0),
        weight: 65.0,
      ),
    ]).animate(animationController);
    rotationAnimation = Tween<double>(begin: 180.0, end: 0.0).animate(
      CurvedAnimation(parent: animationController, curve: Curves.easeOut),
    );
    animationController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
    selectNotificationSubject.close();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      onModelReady: (model) => model.firstLoad(),
      viewModelBuilder: () => HomeViewModel(),
      builder: (_, model, __) => Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            Builder(
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
                      key: ValueKey("main-list"),
                      padding:
                          EdgeInsets.fromLTRB(Gap.m, Gap.xl, Gap.m, Gap.zero),
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
                          onTap: () => model.goToSearchSuggestion(),
                          child: SearchInput(),
                        ),
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
            Positioned(
              right: Gap.m,
              bottom: Gap.m,
              child: HomeFab(
                animationController: animationController,
                rotationAnimation: rotationAnimation,
                searchAnimation: searchAnimation,
                favAnimation: favAnimation,
                settingAnimation: settingAnimation,
                searchAction: () => model.goToSearchSuggestion(),
                favAction: () => model.goToFavorite(),
                settingAction: () => model.goToSetting(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
