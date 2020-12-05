import 'dart:convert';

import 'package:resto/data/model/restaurant_model.dart';

RestaurantsResponseModel restaurantsResponseModelFromJson(String str) =>
    RestaurantsResponseModel.fromJson(json.decode(str));

String restaurantsResponseModelToJson(RestaurantsResponseModel data) =>
    json.encode(data.toJson());

class RestaurantsResponseModel {
  RestaurantsResponseModel({
    this.error,
    this.message,
    this.count,
    this.restaurants,
  });

  bool error;
  String message;
  int count;
  List<RestaurantModel> restaurants;

  factory RestaurantsResponseModel.fromJson(Map<String, dynamic> json) =>
      RestaurantsResponseModel(
        error: json["error"] == null ? null : json["error"],
        message: json["message"] == null ? null : json["message"],
        count: json["count"] == null ? null : json["count"],
        restaurants: json["restaurants"] == null
            ? null
            : List<RestaurantModel>.from(
                json["restaurants"].map((x) => RestaurantModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error == null ? null : error,
        "message": message == null ? null : message,
        "count": count == null ? null : count,
        "restaurants": restaurants == null
            ? null
            : List<dynamic>.from(restaurants.map((x) => x.toJson())),
      };
}
