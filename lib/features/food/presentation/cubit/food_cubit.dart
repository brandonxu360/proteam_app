import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:proteam_app/features/food/domain/entities/food_entity.dart';
import 'package:proteam_app/features/food/domain/usecases/create_food_usecase.dart';
import 'package:proteam_app/features/food/domain/usecases/delete_food_usecase.dart';
import 'package:proteam_app/features/food/domain/usecases/get_foods_usecase.dart';

part 'food_state.dart';

class FoodCubit extends Cubit<FoodState> {
  final CreateFoodUseCase createFoodUseCase;
  final DeleteFoodUseCase deleteFoodUseCase;
  final GetFoodsUseCase getFoodsUseCase;
  FoodCubit(
      {required this.createFoodUseCase,
      required this.deleteFoodUseCase,
      required this.getFoodsUseCase})
      : super(FoodInitial());

  // Create a food
  Future<void> createFood({required FoodEntity food}) async {

    // Emit loading state
    emit(FoodCreateInProgress());

    // Execute the create food use case
    final result = await createFoodUseCase.call(food);

    // Emit a state depending on the result
    result.fold((l) => emit(FoodFailure()), (r) => emit(FoodCreateSuccess()));
  }

  // Delete a food
  Future<void> deleteFood({required FoodEntity food}) async {

    // Emit loading state
    emit(FoodDeleteInProgress());

    // Execute the delete food use case
    final result = await deleteFoodUseCase.call(food);

    // Emit a state depending on the result
    result.fold((l) => emit(FoodFailure()), (r) => emit(FoodDeleteSuccess()));
  }

  // Get the list of existing foods
  Future<void> getFoods() async {

    // Emit the loading state
    emit(FoodsLoadInProgress());

    // Execute the get foods use case
    final result = await getFoodsUseCase.call();

    // Emit a state depending on the reuslt
    result.fold((l) => emit(FoodFailure()), (r) => emit(FoodsLoadSuccess(foods: r)));
  }
}
