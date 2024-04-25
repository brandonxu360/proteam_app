part of 'day_meals_cubit.dart';

sealed class DayMealsState extends Equatable {
  const DayMealsState();

  @override
  List<Object> get props => [];
}

final class DayMealsInitial extends DayMealsState {}
