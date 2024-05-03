import 'dart:convert';
import 'package:http/http.dart';
import 'package:proteam_app/env/env.dart';
import 'package:proteam_app/features/food/data/data_sources/food_api_data_source.dart';
import 'package:proteam_app/features/food/data/models/food_model.dart';
import 'package:proteam_app/features/food/domain/entities/food_entity.dart';

class FoodApiDataSourceImpl extends FoodApiDataSource {
  final Client client;

  FoodApiDataSourceImpl({required this.client});

  // Query and return the top 20 query results for foods of type Branded and FNDDS (survey) from FoodData Central
  @override
  Future<List<FoodEntity>> searchFood(String foodName) async {
    final apiKey = Env.fdcApiKey;

    // Create the query
    final url = Uri.parse(
        'https://api.nal.usda.gov/fdc/v1/foods/search?api_key=$apiKey&query=$foodName&dataType=Branded,Survey%20(FNDDS)');

    // Make the query
    final response = await client.get(url);

    // If successful (success response code) attempt to parse 20 food entities from the json response
    if (response.statusCode == 200) {
      // Get the individual food jsons
      final json = jsonDecode(response.body);
      final List<dynamic> foodsJson = json['foods'];

      // Initialize an empty list to hold the successfully parsed food entities
      final List<FoodEntity> foods = [];

      int parsedCount = 0; // Track the number of successfully parsed items

      // Iterate through the list until we reach the desired count of 20 or the end of the list
      for (var i = 0; parsedCount < 20 && i < foodsJson.length; i++) {
        final foodJson = foodsJson[i];

        try {
          final foodModel = FoodModel.fromJson(foodJson);
          final foodEntity = foodModel.toFoodEntity();
          foods.add(foodEntity);
          parsedCount++; // Increment the count of successfully parsed items
        } catch (e) {
          print('Skipping food item due to parsing error: $e');
        }
      }

      return foods;
    } else {
      throw Exception('Failed to load foods');
    }
  }
}
