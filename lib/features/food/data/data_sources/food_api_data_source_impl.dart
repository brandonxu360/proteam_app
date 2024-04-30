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

      // Iterate through the first 20 items or until the end of the list
      for (var i = 0; i < foodsJson.length && i < 20; i++) {
        final foodJson = foodsJson[i];
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
      }

      return foods;
    } else {
      throw Exception('Failed to load foods');
    }
  }
}
