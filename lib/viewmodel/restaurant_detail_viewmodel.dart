import 'dart:io';

import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:resto/data/api/api_service.dart';
import 'package:resto/data/db/database_helper.dart';
import 'package:resto/data/model/restaurant_model.dart';
import 'package:resto/data/model/review_payload_model.dart';
import 'package:stacked/stacked.dart';

class RestaurantDetailViewModel extends BaseViewModel {
  ApiService _api = ApiService();
  DatabaseHelper _db = DatabaseHelper();

  String _restaurantId;
  RestaurantModel _restaurant;
  RestaurantModel get restaurant => _restaurant;

  String _message = "";
  String get message => _message;

  RestaurantState _state;
  RestaurantState get state => _state;

  bool _showReviewModal = false;
  bool get showReviewModal => _showReviewModal;

  bool _tryingToGiveReview = false;
  bool get tryingToGiveReview => _tryingToGiveReview;

  bool _tryingToFavAction = false;
  bool get tryingToFavAction => _tryingToFavAction;

  bool _isFav = false;
  bool get isFav => _isFav;

  Future<void> _checkIsFav() async {
    var result = await _db.getFavoriteById(_restaurantId);
    _isFav = result.isNotEmpty;
  }

  void toogleshowReviewModal() {
    _showReviewModal = !_showReviewModal;
    notifyListeners();
  }

  Future<void> firstLoad(String id) async {
    _restaurantId = id;
    runBusyFuture(_fetchRestaurant());
    runBusyFuture(_checkIsFav());
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

  Future<void> _addToFav() async {
    try {
      await _db.insertFavorite(_restaurant);
      _isFav = true;
    } catch (e) {
      print(">>> Gagal menambahkan ke favorit");
      // show error message
    }
  }

  Future<void> _removeFromFav() async {
    try {
      await _db.removeFavorite(_restaurantId);
      _isFav = false;
    } catch (e) {
      print(">>> Gagal menghapus dari favorit");
      // show error message
    }
  }

  Future<void> toogleFav() async {
    _tryingToFavAction = true;
    notifyListeners();
    if (_isFav) {
      await _removeFromFav();
    } else {
      await _addToFav();
    }
    _tryingToFavAction = false;
    notifyListeners();
  }

  Future<void> giveReview({
    String name,
    String review,
    BuildContext context,
  }) async {
    _tryingToGiveReview = true;
    notifyListeners();

    try {
      _tryingToGiveReview = true;
      notifyListeners();
      if (name.isEmpty) {
        _showFlushbar(context: context, message: "Nama tidak boleh kosong");
      } else if (review.isEmpty) {
        _showFlushbar(context: context, message: "Review tidak boleh kosong");
      } else {
        await _api.giveReview(ReviewPayloadModel(
          id: _restaurant.id,
          name: name,
          review: review,
        ));
        await _fetchRestaurant();
        toogleshowReviewModal();
        _showFlushbar(context: context, message: "Berhasil menambah review");
      }
    } on SocketException {
      _showFlushbar(
          context: context, message: "Mohon periksa koneksi internet anda");
    } catch (e) {
      _showFlushbar(context: context, message: e.toString());
    } finally {
      _tryingToGiveReview = false;
      notifyListeners();
    }
  }

  void _showFlushbar({BuildContext context, String message}) {
    Flushbar(
      duration: const Duration(milliseconds: 3000),
      flushbarPosition: FlushbarPosition.TOP,
      backgroundColor: Colors.redAccent,
      message: message,
    )..show(context);
  }
}

enum RestaurantState { Loading, NoData, HasData, Error }
