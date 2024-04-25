import 'package:dartz/dartz.dart';
import 'package:proteam_app/core/error/failures.dart';
import 'package:proteam_app/features/log/data/data_sources/log_remote_data_source.dart';
import 'package:proteam_app/features/log/domain/entities/meal_entry_entity.dart';
import 'package:proteam_app/features/log/domain/repositories/log_repository.dart';

class LogRepositoryImpl implements LogRepository {

  final LogRemoteDataSource logRemoteDataSource;

  LogRepositoryImpl({required this.logRemoteDataSource});

  @override
  Future<Either<Failure, List<MealEntryEntity>>> getMealsInDay(String date) {
    // TODO: implement getMealsInDay
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> logMeal(MealEntryEntity meal) {
    // TODO: implement logMeal
    throw UnimplementedError();
  }

}