part of 'food_log_cubit.dart';

sealed class FoodLogState extends Equatable {
  const FoodLogState();

  @override
  List<Object> get props => [];
}

final class FoodlogInitial extends FoodLogState {}

final class FoodLogInProgress extends FoodLogState {}

final class FoodLogSuccess extends FoodLogState {}

final class FoodLogFailure extends FoodLogState {}
