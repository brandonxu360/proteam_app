import 'package:proteam_app/features/log/data/models/food_entry_model.dart';
import 'package:proteam_app/features/log/domain/entities/meal_entry_entity.dart';

class MealEntryModel extends MealEntryEntity {
  MealEntryModel({required super.foodEntries, required super.mealType});

  // Conversion method from MealEntryEntity to MealEntryModel
  factory MealEntryModel.fromMealEntryEntity(MealEntryEntity mealEntryEntity) {
    return MealEntryModel(
      mealType: mealEntryEntity.mealType,
      foodEntries: mealEntryEntity.foodEntries,
    );
  }

  // Firebase serialization method
  Map<String, dynamic> toJson() {
    return {
      'mealType': mealType,
      'foodEntries': foodEntries
          .map((foodEntry) => FoodEntryModel.fromEntity(foodEntry).toDocument())
          .toList(),
    };
  }

  // Factory method for deserialization
  factory MealEntryModel.fromJson(Map<String, dynamic> json) {
    return MealEntryModel(
      mealType: json['mealType'],
      foodEntries: (json['foodEntries'] as List<dynamic>)
          .map((entryJson) => FoodEntryModel.fromSnapshot(entryJson))
          .toList(),
    );
  }
}
