import 'package:dartz/dartz.dart';
import 'package:proteam_app/core/error/failures.dart';
import 'package:proteam_app/features/food/domain/entities/food_entity.dart';
import 'package:proteam_app/features/food/domain/repositories/food_repository.dart';

class CreateFoodUseCase {
  final FoodRepository foodRepository;

  CreateFoodUseCase({required this.foodRepository});

  Future<Either<Failure, void>> call(FoodEntity foodEntity) async {
    return await foodRepository.createFood(foodEntity);
  }
  
}