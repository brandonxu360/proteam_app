import 'package:dartz/dartz.dart';
import 'package:proteam_app/core/error/failures.dart';
import 'package:proteam_app/features/log/domain/entities/meal_entry_entity.dart';
import 'package:proteam_app/features/log/domain/repositories/log_repository.dart';

class LogMealUseCase {
  final LogRepository logRepository;

  LogMealUseCase({required this.logRepository});

  Future<Either<Failure, void>> call(MealEntryEntity meal) async {
    return logRepository.logMeal(meal);
  }
}