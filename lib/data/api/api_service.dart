import 'package:http/http.dart' as http;
import 'package:resto/common/config.dart';
import 'package:resto/data/model/restaurant_detail_response_model.dart';

import 'package:resto/data/model/restaurants_response_model.dart';
import 'package:resto/data/model/restaurants_search_response_model.dart';
import 'package:resto/data/model/review_payload_model.dart';

class ApiService {
  Future<RestaurantsResponseModel> getRestaurants() async {
    final response = await http.get("$BASE_URL/list");
    if (response.statusCode == 200) {
      return restaurantsResponseModelFromJson(response.body);
    } else {
      throw Exception('Gagal mengambil data');
    }
  }

  Future<RestaurantDetailResponseModel> getRestaurant(String id) async {
    final response = await http.get("$BASE_URL/detail/$id");
    if (response.statusCode == 200) {
      return restaurantDetailResponseModelFromJson(response.body);
    } else {
      throw Exception('Gagal mengambil data');
    }
  }

  Future<RestaurantsSearchResponseModel> searchRestaurants(String query) async {
    final response = await http.get("$BASE_URL/search?q=$query");
    if (response.statusCode == 200) {
      return restaurantsSearchResponseModelFromJson(response.body);
    } else {
      throw Exception('Gagal mengambil data');
    }
  }

  Future<void> giveReview(ReviewPayloadModel payload) async {
    print(reviewPayloadModelToJson(payload));
    final response = await http.post(
      "$BASE_URL/review",
      headers: {
        'Content-type': 'application/json',
        'X-Auth-Token': API_KEY,
      },
      body: reviewPayloadModelToJson(payload),
    );
    print(response);
    if (response.statusCode == 200) {
      return restaurantsSearchResponseModelFromJson(response.body);
    } else {
      print(response.statusCode);
      print(response.body);
      throw Exception('Gagal menambah review');
    }
  }
}
