import 'package:dartz/dartz.dart';
import 'package:proteam_app/core/error/failures.dart';
import 'package:proteam_app/features/log/domain/entities/meal_entry_entity.dart';
import 'package:proteam_app/features/log/domain/repositories/log_repository.dart';

class GetMealsInDayUseCase {
  final LogRepository logRepository;

  GetMealsInDayUseCase({required this.logRepository});

  Future<Either<Failure, List<MealEntryEntity>>> call(
      String date, String uid) async {
    return logRepository.getMealsInDay(date, uid);
  }
}
