import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:proteam_app/features/food/data/data_sources/food_api_data_source.dart';
import 'package:proteam_app/features/food/data/data_sources/food_api_data_source_impl.dart';
import 'package:proteam_app/features/food/domain/entities/food_entity.dart';

import 'http_responses.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  group('search food using API tests', () {
    late MockHttpClient mockHttpClient;
    late FoodApiDataSource foodApiDataSource;

    setUp(() {
      mockHttpClient = MockHttpClient();
      foodApiDataSource = FoodApiDataSourceImpl(client: mockHttpClient);

      registerFallbackValue(Uri.parse(''));
    });

    test('should return a list of food entities', () async {
      // Arrange
      const foodName = 'Cheddar Cheese';

      when(() => mockHttpClient.get(any()))
          .thenAnswer((_) async => http.Response(chedderCheeseTwo, 200));

      // Act
      final foods = await foodApiDataSource.searchFood(foodName);

      // Assert
      expect(foods.length, 2);

      // Validate that each item is a FoodEntity
      expect(foods[0], isA<FoodEntity>());
      expect(foods[1], isA<FoodEntity>());

      // Validate the content of the first food entity
      expect(foods[0].name, 'CHEDDAR CHEESE');
      expect(foods[0].servingSize, 28);
      expect(foods[0].servingSizeUnit, 'g');
      expect(foods[0].calories, 393);
      expect(foods[0].carbs, 7.14);
      expect(foods[0].protein, 21.4);
      expect(foods[0].fat, 32.1);

      // Validate the content of the second food entity
      expect(foods[1].name, 'CHEDDAR CHEESE');
      expect(foods[1].servingSize, 28);
      expect(foods[1].servingSizeUnit, 'g');
      expect(foods[1].calories, 432);
      expect(foods[1].carbs, 0);
      expect(foods[1].protein, 25);
      expect(foods[1].fat, 35.7);
    });
  });
}
