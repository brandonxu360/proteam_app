import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:proteam_app/features/food/domain/entities/food_entity.dart';
import 'package:proteam_app/features/food/domain/repositories/food_repository.dart';
import 'package:proteam_app/features/food/domain/usecases/get_foods_usecase.dart';

// Mock repository
class MockFoodRepository extends Mock implements FoodRepository {}

// GetFoodsUseCase testing
void main() {
  // Declare the GetFoodsUseCase and FoodRepository instances that will be used in the tests
  late GetFoodsUseCase getFoodsUseCase;
  late FoodRepository foodRepository;

  setUp(() {
    // Instantiate the foodRepository and getFoodsUseCase
    foodRepository = MockFoodRepository();
    getFoodsUseCase = GetFoodsUseCase(foodRepository: foodRepository);
  });

  // Test the correct call made by the use case to the repository
  test('should call the [FoodRepository.getFoods]', () async {
    // * ARRANGE
    when(() => foodRepository.getFoods())
        .thenAnswer((_) async => const Right(<FoodEntity>[]));

    // * ACT
    final result = await getFoodsUseCase.call();

    // * ASSERT

    // Expected output
    expect(result, equals(const Right(<FoodEntity>[])));

    // The correct call was made once
    verify(() => foodRepository.getFoods()).called(1);

    // No additional unexpected interactions
    verifyNoMoreInteractions(foodRepository);
  });
}
