import 'package:proteam_app/features/food/data/models/food_model.dart';

abstract class FoodRemoteDataSource {
  // Create and persist a new food
  Future<void> createFood(FoodModel food);

  // Get a list of all the foods
  Future<List<FoodModel>> getFoods();

  // Delete a food
  Future<void> deleteFood(FoodModel food);
}
