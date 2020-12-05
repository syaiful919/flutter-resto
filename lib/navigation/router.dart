import 'package:auto_route/auto_route_annotations.dart';
import 'package:resto/ui/pages/home_page.dart';
import 'package:resto/ui/pages/restaurant_detail_page.dart';
import 'package:resto/ui/pages/search_suggestion_page.dart';

@MaterialAutoRouter()
class $Router {
  @initial
  HomePage home;
  SearchSuggestionPage searchSuggestion;
  RestaurantDetailPage restaurantDetail;
}
