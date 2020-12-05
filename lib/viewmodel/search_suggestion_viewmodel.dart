import 'dart:async';
import 'dart:io';

import 'package:resto/data/api/api_service.dart';
import 'package:resto/data/model/restaurant_model.dart';
import 'package:resto/data/model/restaurants_search_response_model.dart';
import 'package:resto/navigation/navigation_service.dart';
import 'package:resto/navigation/router.gr.dart';
import 'package:stacked/stacked.dart';

class SearchSuggestionViewModel extends BaseViewModel {
  ApiService _api = ApiService();

  List<RestaurantModel> _restaurants;
  List<RestaurantModel> get restaurants => _restaurants;

  String _message = "";
  String get message => _message;

  RestaurantsState _state;
  RestaurantsState get state => _state;

  Timer _debounce;

  Future<void> inputChanged(String keyword) async {
    if (_debounce?.isActive ?? false) _debounce.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      keyword.isEmpty ? clearSearch() : _fetchRestaurants(keyword);
    });
  }

  void clearSearch() {
    _restaurants = null;
    _state = null;
    notifyListeners();
  }

  Future<void> _fetchRestaurants(String keyword) async {
    try {
      _state = RestaurantsState.Loading;
      notifyListeners();

      RestaurantsSearchResponseModel response =
          await _api.searchRestaurants(keyword);
      if (response?.restaurants != null && response.restaurants.length > 0) {
        _restaurants = response.restaurants;
        _state = RestaurantsState.HasData;
      } else {
        _state = RestaurantsState.NoData;
      }
      if (_message.isNotEmpty) _message = "";
    } on SocketException {
      _state = RestaurantsState.Error;
      _message = "Mohon periksa koneksi internet anda";
    } catch (e) {
      _state = RestaurantsState.Error;
      _message = e.toString();
    } finally {
      notifyListeners();
    }
  }

  void goToRestaurantDetail(String id) {
    NavigationService.pushNamed(
      Routes.restaurantDetail,
      arguments: RestaurantDetailPageArguments(id: id),
    );
  }
}

enum RestaurantsState { Loading, NoData, HasData, Error }
