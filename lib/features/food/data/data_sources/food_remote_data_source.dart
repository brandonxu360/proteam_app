import 'package:proteam_app/features/food/domain/entities/food_entity.dart';

abstract class FoodRemoteDataSource {
  // Create and persist a new food
  Future<void> createFood(FoodEntity food);

  // Get a list of all the foods
  Future<List<FoodEntity>> getFoods();

  // Delete a food
  Future<void> deleteFood(FoodEntity food);
}
