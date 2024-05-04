import 'package:proteam_app/features/log/domain/entities/food_entry_entity.dart';
import 'package:proteam_app/features/log/domain/entities/meal_entry_entity.dart';

abstract class LogRemoteDataSource {
  // Save a food to the database uner the current user, the current day, and the specified meal
  Future<void> logFood(
      FoodEntryEntity food, String date, String mealType, String uid);

  // Save a meal to the database
  Future<void> logMeal(MealEntryEntity meal);

  // Get the meals for a given day given a date (format: xx/xx/xxxx)
  Future<List<MealEntryEntity>> getMealsInDay(String date, String uid);
}
