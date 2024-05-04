import 'package:dartz/dartz.dart';
import 'package:proteam_app/core/error/failures.dart';
import 'package:proteam_app/features/log/domain/entities/food_entry_entity.dart';
import 'package:proteam_app/features/log/domain/entities/meal_entry_entity.dart';

abstract class LogRepository {
  // Save a food to the given meal (standardized through string const in mealconst) and date
  Future<Either<Failure, void>> logFood(FoodEntryEntity food, String date, String mealType, String uid);

  // Save a meal to the database
  Future<Either<Failure, void>> logMeal(MealEntryEntity meal);

  // Get the meals for a given day given a date (format: xx/xx/xxxx)
  Future<Either<Failure, List<MealEntryEntity>>> getMealsInDay(String date, String uid);
}
