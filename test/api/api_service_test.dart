import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:resto/data/api/api_service.dart';
import 'package:resto/data/model/restaurant_detail_response_model.dart';
import 'package:resto/data/model/restaurants_response_model.dart';

class MockClient extends Mock implements ApiService {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group("Api service test", () {
    MockClient api;

    setUp(() {
      api = MockClient();
    });

    test('Get restaurant list', () async {
      when(api.getRestaurants()).thenAnswer((_) async {
        var result =
            await rootBundle.loadString('assets/json/restaurant_list.json');

        return restaurantsResponseModelFromJson(result);
      });

      var response = await api.getRestaurants();
      var firstRestaurant = response.restaurants[0];
      expect(firstRestaurant.name, "Melting Pot");
    });

    test('Get restaurant by id', () async {
      String id = "rqdv5juczeskfw1e867";
      when(api.getRestaurant(id)).thenAnswer((_) async {
        var result =
            await rootBundle.loadString('assets/json/restaurant_detail.json');

        return restaurantDetailResponseModelFromJson(result);
      });
      final response = await api.getRestaurant(id);
      var restaurant = response.restaurant;
      expect(restaurant.name, "Melting Pot");
    });
  });
}
