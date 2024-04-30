part of 'food_cubit.dart';

sealed class FoodState extends Equatable {
  const FoodState();

  @override
  List<Object> get props => [];
}

// Initial state
final class FoodInitial extends FoodState {}

// Represents the loading state when getting the list of foods
class FoodsLoadInProgress extends FoodState {}

class FoodCreateInProgress extends FoodState {}

class FoodDeleteInProgress extends FoodState {}

// Represents foods loading success and carries the list of foods
class FoodsLoadSuccess extends FoodState {
  final List<FoodEntity> foods;

  const FoodsLoadSuccess({required this.foods});

  @override
  List<Object> get props => [foods];
}

class FoodCreateSuccess extends FoodState {}

class FoodDeleteSuccess extends FoodState {}

// Represents a general failure
class FoodFailure extends FoodState {}
