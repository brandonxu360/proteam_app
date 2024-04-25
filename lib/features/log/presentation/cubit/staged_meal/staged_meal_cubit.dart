import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:proteam_app/features/food/domain/entities/food_entity.dart';
import 'package:proteam_app/features/log/domain/entities/food_entry_entity.dart';
import 'package:proteam_app/features/log/domain/entities/meal_entry_entity.dart';
import 'package:proteam_app/features/log/domain/use_cases/log_meal_usecase.dart';

part 'staged_meal_state.dart';

// Manages state of the staged meal when user is adding/removing foods to create a meal
class StagedMealCubit extends Cubit<StagedMealState> {
  // The staged meal - always starts empty
  final MealEntryEntity stagedMeal = MealEntryEntity(foodEntries: []);

  final LogMealUseCase logMealUseCase;

  StagedMealCubit({required this.logMealUseCase}) : super(StagedMealInitial());

  // Stage a food in the staged meal
  void stageFood({required FoodEntity food, required double quantity}) {
    try {
      // Convert the [FoodEntity] and the servings amount to a [FoodEntryEntity]
      final foodEntry = FoodEntryEntity(
        name: food.name,
        calories: (food.calories * (quantity / food.servingSize)).toInt(),
        carbs: (food.carbs * (quantity / food.servingSize)).toInt(),
        protein: (food.protein * (quantity / food.servingSize)).toInt(),
        fat: (food.fat * (quantity / food.servingSize)).toInt(),
        quantity: quantity,
        // Assume same units for now
        quantityUnits: food.servingSizeUnit,
      );

      // Add the [FoodEntryEntity] to the staged meal
      stagedMeal.foodEntries.add(foodEntry);

      // Emit the updated state
      emit(StagedMealLoadSuccess(stagedMeal: stagedMeal));
    } catch (_) {
      emit(StagedMealLoadFail());
    }
  }

  // Log the staged meal by calling the [logMeal] usecase
  Future<void> logMeal() async {
    try {
      emit(StagedMealLogInProgress());

      // TODO: check if staged meal is valid? (not empty)... or handle this later in the call flow
      final result = await logMealUseCase.call(stagedMeal);

      result.fold((l) => emit(StagedMealLogFailure()), (r) => emit(StagedMealLogSuccess()))
    } catch (_) {
      emit(StagedMealLogFailure());
    }
  }
}
