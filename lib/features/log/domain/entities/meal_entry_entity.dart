import 'package:proteam_app/features/log/domain/entities/food_entry_entity.dart';

// A meal entry, representing a collection of food entries
class MealEntryEntity {
  // The type of meal (breakfast, lunch, dinner, etc) - use MealConst constants
  String mealType;

  // The list of foods that make up the meal
  final List<FoodEntryEntity> foodEntries;

  MealEntryEntity({required this.foodEntries, required this.mealType});
}
