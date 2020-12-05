import 'dart:io';

import 'package:resto/data/api/api_service.dart';
import 'package:resto/data/model/restaurant_model.dart';
import 'package:resto/data/model/restaurants_response_model.dart';
import 'package:stacked/stacked.dart';

class HomeViewModel extends BaseViewModel {
  ApiService _api = ApiService();

  List<RestaurantModel> _restaurants;
  List<RestaurantModel> get restaurants => _restaurants;

  String _message = "";
  String get message => _message;

  RestaurantsState _state;
  RestaurantsState get state => _state;

  Future<void> firstLoad() async {
    runBusyFuture(_fetchRestaurants());
  }

  Future<void> _fetchRestaurants() async {
    try {
      _state = RestaurantsState.Loading;
      notifyListeners();

      RestaurantsResponseModel response = await _api.restaurants();
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
    }
  }
}

enum RestaurantsState { Loading, NoData, HasData, Error }
