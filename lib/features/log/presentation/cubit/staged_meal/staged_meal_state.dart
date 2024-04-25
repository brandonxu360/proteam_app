part of 'staged_meal_cubit.dart';

sealed class StagedMealState extends Equatable {
  const StagedMealState();

  @override
  List<Object> get props => [];
}

final class StagedMealInitial extends StagedMealState {}

final class StagedMealLoadSuccess extends StagedMealState {
  final MealEntryEntity stagedMeal;

  const StagedMealLoadSuccess({required this.stagedMeal});
}

// Updating the staged meal failed
final class StagedMealLoadFail extends StagedMealState {}

final class StagedMealLogInProgress extends StagedMealState {}

final class StagedMealLogSuccess extends StagedMealState {}

final class StagedMealLogFailure extends StagedMealState {}
