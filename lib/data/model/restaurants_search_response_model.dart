import 'dart:convert';

import 'package:resto/data/model/restaurant_model.dart';

RestaurantsSearchResponseModel restaurantsSearchResponseModelFromJson(
        String str) =>
    RestaurantsSearchResponseModel.fromJson(json.decode(str));

String restaurantsSearchResponseModelToJson(
        RestaurantsSearchResponseModel data) =>
    json.encode(data.toJson());

class RestaurantsSearchResponseModel {
  RestaurantsSearchResponseModel({
    this.error,
    this.founded,
    this.restaurants,
  });

  bool error;
  int founded;
  List<RestaurantModel> restaurants;

  factory RestaurantsSearchResponseModel.fromJson(Map<String, dynamic> json) =>
      RestaurantsSearchResponseModel(
        error: json["error"] == null ? null : json["error"],
        founded: json["founded"] == null ? null : json["founded"],
        restaurants: json["restaurants"] == null
            ? null
            : List<RestaurantModel>.from(
                json["restaurants"].map((x) => RestaurantModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error == null ? null : error,
        "founded": founded == null ? null : founded,
        "restaurants": restaurants == null
            ? null
            : List<dynamic>.from(restaurants.map((x) => x.toJson())),
      };
}
