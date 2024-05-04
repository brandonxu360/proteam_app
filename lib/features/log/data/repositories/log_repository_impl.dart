import 'package:dartz/dartz.dart';
import 'package:proteam_app/core/error/failures.dart';
import 'package:proteam_app/features/log/data/data_sources/log_remote_data_source.dart';
import 'package:proteam_app/features/log/domain/entities/food_entry_entity.dart';
import 'package:proteam_app/features/log/domain/entities/meal_entry_entity.dart';
import 'package:proteam_app/features/log/domain/repositories/log_repository.dart';

class LogRepositoryImpl implements LogRepository {
  final LogRemoteDataSource logRemoteDataSource;

  LogRepositoryImpl({required this.logRemoteDataSource});

  @override
  Future<Either<Failure, List<MealEntryEntity>>> getMealsInDay(
      String date, String uid) async {
    try {
      final meals = await logRemoteDataSource.getMealsInDay(date, uid);

      return Right(meals);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> logMeal(MealEntryEntity meal) {
    // TODO: implement logMeal
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> logFood(
      FoodEntryEntity food, String date, String mealType, String uid) async {
    try {
      // Attempt to call the remote data source to save the food
      await logRemoteDataSource.logFood(food, date, mealType, uid);

      // Return a right value to signify success
      return const Right(null);
    } catch (e) {
      // Return a left value on exceptions to signify failure
      return Left(ServerFailure());
    }
  }
}
