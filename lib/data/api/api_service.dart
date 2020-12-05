import 'package:http/http.dart' as http;
import 'package:resto/common/config.dart';

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
}
