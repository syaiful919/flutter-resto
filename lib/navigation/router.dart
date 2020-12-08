import 'package:auto_route/auto_route_annotations.dart';
import 'package:resto/ui/pages/favorite_page/favorite_page.dart';
import 'package:resto/ui/pages/home_page/home_page.dart';
import 'package:resto/ui/pages/restaurant_detail_page/restaurant_detail_page.dart';
import 'package:resto/ui/pages/search_suggestion_page/search_suggestion_page.dart';
import 'package:resto/ui/pages/setting_page/setting_page.dart';

@MaterialAutoRouter()
class $Router {
  @initial
  HomePage home;
  SearchSuggestionPage searchSuggestion;
  RestaurantDetailPage restaurantDetail;
  FavoritePage favoritePage;
  SettingPage settingPage;
}
