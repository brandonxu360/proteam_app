import 'package:dartz/dartz.dart';
import 'package:proteam_app/core/error/failures.dart';
import 'package:proteam_app/features/food/data/data_sources/food_remote_data_source.dart';
import 'package:proteam_app/features/food/domain/entities/food_entity.dart';
import 'package:proteam_app/features/food/domain/repositories/food_repository.dart';

class FoodRepositoryImpl extends FoodRepository {
  final FoodRemoteDataSource foodRemoteDataSource;

  FoodRepositoryImpl({required this.foodRemoteDataSource});

  @override
  Future<Either<Failure, void>> createFood(FoodEntity food) async {
    try {
      // Call the food remote data source to create a food
      await foodRemoteDataSource.createFood(food);

      // Return a completion future completion indicating success
      return const Right(null);
    } catch (e) {
      // Return a failure on an error
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> deleteFood(FoodEntity food) async {
    try {
      // Call the food remote data source to create a food
      await foodRemoteDataSource.deleteFood(food);

      // Return a completion future completion indicating success
      return const Right(null);
    } catch (e) {
      // Return a failure on an error
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<FoodEntity>>> getFoods() async {
    try {
      // Call the food remote data source to create a food
      final foods = await foodRemoteDataSource.getFoods();

      // Return the list of food entities
      return Right(foods);
    } catch (e) {
      // Return a failure on an error
      return Left(ServerFailure());
    }
  }
  
  // Search for a food by name, return the top 20 results
  @override
  Future<Either<Failure, List<FoodEntity>>> searchFood(String foodName) {
    // TODO: implement searchFood
    throw UnimplementedError();
  }
}
