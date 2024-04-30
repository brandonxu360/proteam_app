import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:proteam_app/features/food/domain/entities/food_entity.dart';
import 'package:proteam_app/features/food/domain/usecases/search_food_usecase.dart';

part 'food_search_state.dart';

class FoodSearchCubit extends Cubit<FoodSearchState> {
  final SearchFoodUseCase searchFoodUseCase;

  FoodSearchCubit({required this.searchFoodUseCase})
      : super(FoodSearchInitial());

  Future<void> searchFood(String foodName) async {
    // Emit the loading state
    emit(FoodSearchInProgress());

    // Call the search food use case
    final searchResult = await searchFoodUseCase.call(foodName);

    // Emit a state depending on success or failure
    searchResult.fold(
        (l) => emit(FoodSearchFailure()), (r) => FoodSearchSuccess(foods: r));
  }
}
