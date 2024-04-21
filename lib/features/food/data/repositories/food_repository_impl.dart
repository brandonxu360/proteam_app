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
    // TODO: implement deleteFood
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> deleteFood(FoodEntity food) {
    // TODO: implement deleteFood
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<FoodEntity>>> getFoods() {
    // TODO: implement getFoods
    throw UnimplementedError();
  }

}