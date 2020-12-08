import 'package:resto/data/model/restaurant_model.dart';

class RestaurantLocalModel {
  RestaurantLocalModel({
    this.id,
    this.name,
    this.description,
    this.city,
    this.pictureId,
    this.rating,
  });

  String id;
  String name;
  String description;
  String pictureId;
  String city;
  double rating;

  factory RestaurantLocalModel.fromJson(Map<String, dynamic> json) =>
      RestaurantLocalModel(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        description: json["description"] == null ? null : json["description"],
        pictureId: json["pictureId"] == null ? null : json["pictureId"],
        city: json["city"] == null ? null : json["city"],
        rating: json["rating"] == null ? null : json["rating"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "description": description == null ? null : description,
        "pictureId": pictureId == null ? null : pictureId,
        "city": city == null ? null : city,
        "rating": rating == null ? null : rating,
      };

  factory RestaurantLocalModel.fromRestaurant(RestaurantModel restaurant) =>
      RestaurantLocalModel(
        id: restaurant.id,
        name: restaurant.name,
        description: restaurant.description,
        pictureId: restaurant.pictureId,
        city: restaurant.city,
        rating: restaurant.rating,
      );
}
