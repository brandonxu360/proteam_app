import 'package:dartz/dartz.dart';
import 'package:proteam_app/core/error/failures.dart';
import 'package:proteam_app/features/log/domain/entities/meal_entry_entity.dart';

abstract class LogRepository {

  // Save a meal to the database
  Future<Either<Failure, void>> logMeal(MealEntryEntity meal);

  // Get the meals for a given day given a date (format: xx/xx/xxxx)
  Future<Either<Failure, List<MealEntryEntity>>> getMealsInDay(String date);
}