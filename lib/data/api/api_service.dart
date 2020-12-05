import 'package:http/http.dart' as http;
import 'package:resto/common/config.dart';
import 'package:resto/data/model/restaurant_detail_response_model.dart';

import 'package:resto/data/model/restaurants_response_model.dart';

class ApiService {
  Future<RestaurantsResponseModel> restaurants() async {
    final response = await http.get("$BASE_URL/list");
    if (response.statusCode == 200) {
      return restaurantsResponseModelFromJson(response.body);
    } else {
      throw Exception('Failed to load restaurant list');
    }
  }

  Future<RestaurantDetailResponseModel> restaurant(String id) async {
    final response = await http.get("$BASE_URL/detail/$id");
    if (response.statusCode == 200) {
      return restaurantDetailResponseModelFromJson(response.body);
    } else {
      throw Exception('Failed to load restaurant list');
    }
  }
}
