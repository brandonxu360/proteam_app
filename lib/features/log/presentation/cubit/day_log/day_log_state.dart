part of 'day_log_cubit.dart';

sealed class DayLogState extends Equatable {
  const DayLogState();

  @override
  List<Object> get props => [];
}

final class DayLogInitial extends DayLogState {}

final class DayLogGetMealsInProgress extends DayLogState {}

final class DayLogGetMealsSuccess extends DayLogState {
  final List<MealEntryEntity> meals;

  const DayLogGetMealsSuccess({required this.meals});
}

final class DayLogGetMealsFailure extends DayLogState {}
