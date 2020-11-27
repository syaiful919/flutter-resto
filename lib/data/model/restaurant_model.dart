class RestaurantModel {
  RestaurantModel({
    this.id,
    this.name,
    this.description,
    this.pictureId,
    this.city,
    this.rating,
    this.menus,
  });

  String id;
  String name;
  String description;
  String pictureId;
  String city;
  double rating;
  MenuModel menus;

  factory RestaurantModel.fromJson(Map<String, dynamic> json) =>
      RestaurantModel(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        description: json["description"] == null ? null : json["description"],
        pictureId: json["pictureId"] == null ? null : json["pictureId"],
        city: json["city"] == null ? null : json["city"],
        rating: json["rating"] == null ? null : json["rating"].toDouble(),
        menus: json["menus"] == null ? null : MenuModel.fromJson(json["menus"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "description": description == null ? null : description,
        "pictureId": pictureId == null ? null : pictureId,
        "city": city == null ? null : city,
        "rating": rating == null ? null : rating,
        "menus": menus == null ? null : menus.toJson(),
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
