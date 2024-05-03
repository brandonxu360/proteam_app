import 'package:proteam_app/features/food/domain/entities/food_entity.dart';

abstract class FoodApiDataSource {
// Search for a food by name, return the top 20 results
  Future<List<FoodEntity>> searchFood(String foodName);
}