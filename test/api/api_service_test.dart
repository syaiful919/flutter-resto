import 'package:flutter_test/flutter_test.dart';
import 'package:resto/data/api/api_service.dart';

void main() {
  group("Api service test", () {
    ApiService api;

    setUp(() {
      api = ApiService();
    });

    test('Get restaurant list', () async {
      final response = await api.restaurants();
      var firstRestaurant = response.restaurants[0];
      expect(firstRestaurant.name, "Melting Pot");
    });

    test('Get restaurant by id', () async {
      String id = "rqdv5juczeskfw1e867";
      final response = await api.restaurant(id);
      var restaurant = response.restaurant;
      expect(restaurant.name, "Melting Pot");
    });
  });
}
