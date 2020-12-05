import 'dart:io';

import 'package:resto/data/api/api_service.dart';
import 'package:resto/data/model/restaurant_model.dart';
import 'package:stacked/stacked.dart';

class RestaurantDetailViewModel extends BaseViewModel {
  ApiService _api = ApiService();

  String _restaurantId;
  RestaurantModel _restaurant;
  RestaurantModel get restaurant => _restaurant;

  String _message = "";
  String get message => _message;

  RestaurantState _state;
  RestaurantState get state => _state;

  bool _showReviewModal = false;
  bool get showReviewModal => _showReviewModal;

  void toogleshowReviewModal() {
    _showReviewModal = !_showReviewModal;
    notifyListeners();
  }

  Future<void> firstLoad(String id) async {
    _restaurantId = id;
    runBusyFuture(_fetchRestaurant());
  }

  Future<void> _fetchRestaurant() async {
    try {
      _state = RestaurantState.Loading;
      notifyListeners();

      var response = await _api.restaurant(_restaurantId);
      if (response?.restaurant != null) {
        _restaurant = response.restaurant;
        _state = RestaurantState.HasData;
      } else {
        _state = RestaurantState.NoData;
      }
      if (_message.isNotEmpty) _message = "";
    } on SocketException {
      _state = RestaurantState.Error;
      _message = "Mohon periksa koneksi internet anda";
    } catch (e) {
      _state = RestaurantState.Error;
      _message = e.toString();
    }
  }
}

enum RestaurantState { Loading, NoData, HasData, Error }
