import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:proteam_app/features/food/domain/entities/food_entity.dart';
import 'package:proteam_app/features/food/domain/repositories/food_repository.dart';
import 'package:proteam_app/features/food/domain/usecases/delete_food_usecase.dart';

// Mock repository
class MockFoodRepository extends Mock implements FoodRepository {}

// DeleteFoodUseCase testing
void main() {
  // Declare the CreateFoodUseCase and FoodRepository instances that will be used in the tests
  late DeleteFoodUseCase deleteFoodUseCase;
  late FoodRepository foodRepository;

  setUpAll(() {
    registerFallbackValue(const FoodEntity(
      name: 'Dummy',
      servingSize: 0,
      servingSizeUnit: 'unit',
      calories: 0,
      carbs: 0,
      protein: 0,
      fat: 0,
    ));
  });

  setUp(() {
    // Instantiate the foodRepository and deleteFoodUseCase
    foodRepository = MockFoodRepository();
    deleteFoodUseCase = DeleteFoodUseCase(foodRepository: foodRepository);
  });

  FoodEntity foodEntity = const FoodEntity(
      name: 'Banana',
      servingSize: 1,
      servingSizeUnit: 'unit',
      calories: 110,
      carbs: 28,
      protein: 1,
      fat: 0);

  // Test the correct call made by the use case to the repository
  test('should call the [FoodRepository.deleteFood]', () async {
    // * ARRANGE
    when(() => foodRepository.deleteFood(any()))
        .thenAnswer((_) async => const Right(null));

    // * ACT
    final result = await deleteFoodUseCase.call(foodEntity);

    // * ASSERT

    // Expected output
    expect(result, equals(const Right(null)));

    // The correct call was made once
    verify(() => foodRepository.deleteFood(foodEntity)).called(1);

    // No additional unexpected interactions
    verifyNoMoreInteractions(foodRepository);
  });
}
