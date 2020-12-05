import 'dart:convert';

List<RestaurantModel> listRestaurantFromRawJson(String data) {
  var result = jsonDecode(data);
  return List<RestaurantModel>.from(
    result['restaurants'].map((x) => RestaurantModel.fromJson(x)),
  );
}

class RestaurantModel {
  RestaurantModel({
    this.id,
    this.name,
    this.description,
    this.city,
    this.pictureId,
    this.menus,
    this.rating,
    this.address,
    this.categories,
    this.customerReviews,
  });

  String id;
  String name;
  String description;
  String pictureId;
  String city;
  double rating;
  MenuModel menus;

  String address;
  List<CategoryModel> categories;
  List<CustomerReviewModel> customerReviews;

  factory RestaurantModel.fromJson(Map<String, dynamic> json) =>
      RestaurantModel(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        description: json["description"] == null ? null : json["description"],
        pictureId: json["pictureId"] == null ? null : json["pictureId"],
        city: json["city"] == null ? null : json["city"],
        rating: json["rating"] == null ? null : json["rating"].toDouble(),
        menus: json["menus"] == null ? null : MenuModel.fromJson(json["menus"]),
        address: json["address"] == null ? null : json["address"],
        categories: json["categories"] == null
            ? null
            : List<CategoryModel>.from(
                json["categories"].map((x) => CategoryModel.fromJson(x))),
        customerReviews: json["customerReviews"] == null
            ? null
            : List<CustomerReviewModel>.from(json["customerReviews"]
                .map((x) => CustomerReviewModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "description": description == null ? null : description,
        "pictureId": pictureId == null ? null : pictureId,
        "city": city == null ? null : city,
        "rating": rating == null ? null : rating,
        "menus": menus == null ? null : menus.toJson(),
        "address": address == null ? null : address,
        "categories": categories == null
            ? null
            : List<dynamic>.from(categories.map((x) => x.toJson())),
        "customerReviews": customerReviews == null
            ? null
            : List<dynamic>.from(customerReviews.map((x) => x.toJson())),
      };
}

class MenuModel {
  MenuModel({
    this.foods,
    this.drinks,
  });

  List<MenuItemModel> foods;
  List<MenuItemModel> drinks;

  factory MenuModel.fromJson(Map<String, dynamic> json) => MenuModel(
        foods: json["foods"] == null
            ? null
            : List<MenuItemModel>.from(
                json["foods"].map((x) => MenuItemModel.fromJson(x))),
        drinks: json["drinks"] == null
            ? null
            : List<MenuItemModel>.from(
                json["drinks"].map((x) => MenuItemModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "foods": foods == null
            ? null
            : List<dynamic>.from(foods.map((x) => x.toJson())),
        "drinks": drinks == null
            ? null
            : List<dynamic>.from(drinks.map((x) => x.toJson())),
      };
}

class MenuItemModel {
  MenuItemModel({
    this.name,
  });

  String name;

  factory MenuItemModel.fromJson(Map<String, dynamic> json) => MenuItemModel(
        name: json["name"] == null ? null : json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
      };
}

class CategoryModel {
  CategoryModel({
    this.name,
  });

  String name;

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        name: json["name"] == null ? null : json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
      };
}

class CustomerReviewModel {
  CustomerReviewModel({
    this.name,
    this.review,
    this.date,
  });

  String name;
  String review;
  String date;

  factory CustomerReviewModel.fromJson(Map<String, dynamic> json) =>
      CustomerReviewModel(
        name: json["name"] == null ? null : json["name"],
        review: json["review"] == null ? null : json["review"],
        date: json["date"] == null ? null : json["date"],
      );

  Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
        "review": review == null ? null : review,
        "date": date == null ? null : date,
      };
}
