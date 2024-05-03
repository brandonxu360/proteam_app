import 'package:dartz/dartz.dart';
import 'package:proteam_app/core/error/failures.dart';
import 'package:proteam_app/features/food/domain/entities/food_entity.dart';

abstract class FoodRepository {
  // Create and persist a new food
  Future<Either<Failure, void>> createFood(FoodEntity food);

  // Get a list of all the foods
  Future<Either<Failure, List<FoodEntity>>> getFoods();

  // Delete a food
  Future<Either<Failure, void>> deleteFood(FoodEntity food);

  // Search for a food by name, return the top 20 results
  Future<Either<Failure, List<FoodEntity>>> searchFood(String foodName);
}
