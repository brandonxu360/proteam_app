import 'package:dartz/dartz.dart';
import 'package:proteam_app/core/error/failures.dart';
import 'package:proteam_app/core/utils/date_helpers.dart';
import 'package:proteam_app/features/food/domain/entities/food_entity.dart';
import 'package:proteam_app/features/log/domain/entities/food_entry_entity.dart';
import 'package:proteam_app/features/log/domain/repositories/log_repository.dart';

class LogFoodUseCase {
  final LogRepository logRepository;

  LogFoodUseCase({required this.logRepository});

  Future<Either<Failure, void>> call(FoodEntity food, double quantity,
      String meal, DateTime date, String uid) async {
    // Create the relevant [FoodEntryEntity] (note that we are assuming same size units for now)
    final FoodEntryEntity foodEntryEntity = FoodEntryEntity(
        name: food.name,
        calories: food.calories,
        carbs: food.carbs,
        protein: food.protein,
        fat: food.fat,
        quantity: quantity,
        quantityUnits: food.servingSizeUnit,
        actualCalories: (food.calories * (quantity / food.servingSize)),
        actualCarbs: (food.carbs * (quantity / food.servingSize)),
        actualProtein: (food.protein * (quantity / food.servingSize)),
        actualFat: (food.fat * (quantity / food.servingSize)),
        servingSize: food.servingSize,
        servingSizeUnit: food.servingSizeUnit);

    // Convert the datetime to the standardized format (xx/xx/xxxx)
    final String formattedDate = formatDateMDY(date);

    // Pass the parameters into the repository method
    return logRepository.logFood(foodEntryEntity, formattedDate, meal, uid);
  }
}
