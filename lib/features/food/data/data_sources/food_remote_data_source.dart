import 'package:proteam_app/features/food/domain/entities/food_entity.dart';

abstract class FoodRemoteDataSource {
  // Create and persist a new food
  Future<void> createFood(FoodEntity food);

  // Get a list of all the foods
  Future<List<FoodEntity>> getFoods();

  // Delete a food
  Future<void> deleteFood(FoodEntity food);

  // Search for a food by name, return the top 20 results
  Future<List<FoodEntity>> searchFood(String foodName);
}
