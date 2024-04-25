import 'package:proteam_app/features/log/domain/entities/food_entry_entity.dart';

class FoodEntryModel extends FoodEntryEntity {
  FoodEntryModel(
      {required super.name,
      required super.calories,
      required super.carbs,
      required super.protein,
      required super.fat,
      required super.quantity,
      required super.quantityUnits});

  // TODO: Implement firebase conversion methods
}
