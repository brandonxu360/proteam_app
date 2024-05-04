import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:proteam_app/features/food/domain/entities/food_entity.dart';
import 'package:proteam_app/features/log/domain/use_cases/log_food_usecase.dart';

part 'food_log_state.dart';

class FoodLogCubit extends Cubit<FoodLogState> {
  LogFoodUseCase logFoodUseCase;

  FoodLogCubit({required this.logFoodUseCase}) : super(FoodlogInitial());

  // Attempt to log the food and emit in progress, success, and failure states
  Future<void> logFood(FoodEntity food, double quantity, String meal,
      DateTime date, String uid) async {
    emit(FoodLogInProgress());

    final result = await logFoodUseCase.call(food, quantity, meal, date, uid);

    result.fold((l) => emit(FoodLogFailure()), (r) => emit(FoodLogSuccess()));
  }
}
