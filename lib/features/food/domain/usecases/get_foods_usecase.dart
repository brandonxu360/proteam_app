import 'package:dartz/dartz.dart';
import 'package:proteam_app/core/error/failures.dart';
import 'package:proteam_app/features/food/domain/entities/food_entity.dart';
import 'package:proteam_app/features/food/domain/repositories/food_repository.dart';

class GetFoodsUseCase {
  final FoodRepository foodRepository;

  GetFoodsUseCase({required this.foodRepository});

  Future<Either<Failure, List<FoodEntity>>> call() async {
    return foodRepository.getFoods();
  }
  
}