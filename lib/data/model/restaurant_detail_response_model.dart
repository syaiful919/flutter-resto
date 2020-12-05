import 'dart:convert';

import 'package:resto/data/model/restaurant_model.dart';

RestaurantDetailResponseModel restaurantDetailResponseModelFromJson(
        String str) =>
    RestaurantDetailResponseModel.fromJson(json.decode(str));

String restaurantDetailResponseModelToJson(
        RestaurantDetailResponseModel data) =>
    json.encode(data.toJson());

class RestaurantDetailResponseModel {
  RestaurantDetailResponseModel({
    this.error,
    this.message,
    this.restaurant,
  });

  bool error;
  String message;
  RestaurantModel restaurant;

  factory RestaurantDetailResponseModel.fromJson(Map<String, dynamic> json) =>
      RestaurantDetailResponseModel(
        error: json["error"] == null ? null : json["error"],
        message: json["message"] == null ? null : json["message"],
        restaurant: json["restaurant"] == null
            ? null
            : RestaurantModel.fromJson(json["restaurant"]),
      );

  Map<String, dynamic> toJson() => {
        "error": error == null ? null : error,
        "message": message == null ? null : message,
        "restaurant": restaurant == null ? null : restaurant.toJson(),
      };
}
