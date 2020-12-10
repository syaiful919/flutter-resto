import 'package:resto/data/db/database_helper.dart';
import 'package:resto/data/model/restaurant_local_model.dart';
import 'package:resto/navigation/navigation_service.dart';
import 'package:resto/navigation/router.gr.dart';
import 'package:stacked/stacked.dart';

class FavoriteViewModel extends BaseViewModel {
  DatabaseHelper _db = DatabaseHelper();

  List<RestaurantLocalModel> _allRestaurants;
  List<RestaurantLocalModel> _restaurants;

  List<RestaurantLocalModel> get restaurants => _restaurants;

  String _message = "";
  String get message => _message;

  RestaurantsState _state;
  RestaurantsState get state => _state;

  Future<void> firstLoad() async {
    runBusyFuture(_loadFavorites());
  }

  void inputChanged(String keyword) async {
    if (keyword.isNotEmpty) {
      _restaurants = _allRestaurants
          .where((x) =>
              x.name.toLowerCase().contains(keyword) ||
              x.city.toLowerCase().contains(keyword))
          .toList();
    } else {
      _restaurants = _allRestaurants;
    }
    notifyListeners();
  }

  void clearSearch() {
    _restaurants = _allRestaurants;
    notifyListeners();
  }

  Future<void> _loadFavorites() async {
    try {
      _state = RestaurantsState.Loading;
      notifyListeners();

      _allRestaurants = await _db.getFavorites();
      _restaurants = _allRestaurants;
      if (_restaurants != null && _restaurants.length > 0) {
        _state = RestaurantsState.HasData;
      } else {
        _state = RestaurantsState.NoData;
      }
      if (_message.isNotEmpty) _message = "";
    } catch (e) {
      _state = RestaurantsState.Error;
      _message = e.toString();
    }
  }

  void goToRestaurantDetail(String id) async {
    var result = await NavigationService.pushNamed(
      Routes.restaurantDetail,
      arguments: RestaurantDetailPageArguments(id: id),
    );
    if (result != null) runBusyFuture(_loadFavorites());
  }
}

enum RestaurantsState { Loading, NoData, HasData, Error }
