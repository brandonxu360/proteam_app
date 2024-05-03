part of 'food_search_cubit.dart';

sealed class FoodSearchState extends Equatable {
  const FoodSearchState();

  @override
  List<Object> get props => [];
}

final class FoodSearchInitial extends FoodSearchState {}

// Query is being processed
final class FoodSearchInProgress extends FoodSearchState {}

// Query was successful
final class FoodSearchSuccess extends FoodSearchState {
  // The resultant list of foods from the query
  final List<FoodEntity> foods;

  const FoodSearchSuccess({required this.foods});
}

// Query was not successful
final class FoodSearchFailure extends FoodSearchState {}
