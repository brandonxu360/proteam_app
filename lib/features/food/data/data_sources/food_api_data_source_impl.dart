import 'dart:convert';
import 'package:http/http.dart';
import 'package:proteam_app/env/env.dart';
import 'package:proteam_app/features/food/data/data_sources/food_api_data_source.dart';
import 'package:proteam_app/features/food/data/models/food_model.dart';
import 'package:proteam_app/features/food/domain/entities/food_entity.dart';

class FoodApiDataSourceImpl extends FoodApiDataSource {
  final Client client;

  FoodApiDataSourceImpl({required this.client});

  @override
  Future<List<FoodEntity>> searchFood(String foodName) async {
    final apiKey = Env.fdcApiKey;

    // Note that Uri.parse will automatically convert the spaces in the foodName to %20
    final url = Uri.parse(
        'https://api.nal.usda.gov/fdc/v1/foods/search?api_key=$apiKey&query=$foodName');

    final response = await client.get(url);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final List<dynamic> foodsJson = json['foods'];

      final List<FoodEntity> foods = [];

      int parsedCount = 0; // Track the number of successfully parsed items

      // Iterate through the list until we reach the desired count of 20 or the end of the list
      for (var i = 0; parsedCount < 20 && i < foodsJson.length; i++) {
        final foodJson = foodsJson[i];

        try {
          final foodModel = FoodModel.fromJson(foodJson);
          final foodEntity = FoodEntity(
            name: foodModel.name,
            servingSize: foodModel.servingSize,
            servingSizeUnit: foodModel.servingSizeUnit,
            calories: foodModel.calories,
            carbs: foodModel.carbs,
            protein: foodModel.protein,
            fat: foodModel.fat,
          );
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
