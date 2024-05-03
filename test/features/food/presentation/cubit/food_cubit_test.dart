import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:proteam_app/core/error/failures.dart';
import 'package:proteam_app/features/food/domain/entities/food_entity.dart';
import 'package:proteam_app/features/food/domain/usecases/create_food_usecase.dart';
import 'package:proteam_app/features/food/domain/usecases/delete_food_usecase.dart';
import 'package:proteam_app/features/food/domain/usecases/get_foods_usecase.dart';
import 'package:proteam_app/features/food/presentation/cubit/food_cubit/food_cubit.dart';

// Mocked usecase dependencies
class MockCreateFoodUseCase extends Mock implements CreateFoodUseCase {}

class MockDeleteFoodUseCase extends Mock implements DeleteFoodUseCase {}

class MockGetFoodsUseCase extends Mock implements GetFoodsUseCase {}

void main() {
  late CreateFoodUseCase createFoodUseCase;
  late DeleteFoodUseCase deleteFoodUseCase;
  late GetFoodsUseCase getFoodsUseCase;
  late FoodCubit foodCubit;

  late FoodEntity testFoodEntity;

  setUp(() {
    createFoodUseCase = MockCreateFoodUseCase();
    deleteFoodUseCase = MockDeleteFoodUseCase();
    getFoodsUseCase = MockGetFoodsUseCase();

    foodCubit = FoodCubit(
        createFoodUseCase: createFoodUseCase,
        deleteFoodUseCase: deleteFoodUseCase,
        getFoodsUseCase: getFoodsUseCase);
  });

  setUpAll(() {
    testFoodEntity = const FoodEntity(
        name: 'Banana',
        servingSize: 1,
        servingSizeUnit: 'unit',
        calories: 110,
        carbs: 28,
        protein: 1,
        fat: 0);

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

  // Dispose of the cubit after each test
  tearDown(() => foodCubit.close);

  // Test initial state of cubit
  test('initial state should be [FoodInitial]', () async {
    // Assert expected initial state
    expect(foodCubit.state, equals(FoodInitial()));
  });

  group('createFood unit tests', () {
    // Normal case
    blocTest<FoodCubit, FoodState>(
      'emits [FoodCreateInProgress, FoodCreateSuccess] when createFood is successful',
      build: () {
        when(() => createFoodUseCase(any()))
            .thenAnswer((_) async => const Right(null));
        return foodCubit;
      },
      act: (cubit) => cubit.createFood(food: testFoodEntity),
      expect: () => <FoodState>[FoodCreateInProgress(), FoodCreateSuccess()],
    );

    // Exceptional case
    blocTest<FoodCubit, FoodState>(
      'emits [FoodCreateInProgress, FoodFailure] when createFood is unsuccessful',
      build: () {
        when(() => createFoodUseCase(any()))
            .thenAnswer((_) async => Left(ServerFailure()));
        return foodCubit;
      },
      act: (cubit) => cubit.createFood(food: testFoodEntity),
      expect: () => <FoodState>[FoodCreateInProgress(), FoodFailure()],
    );
  });

  group('deleteFood unit tests', () {
    // Normal case
    blocTest<FoodCubit, FoodState>(
      'emits [FoodDeleteInProgress, FoodDeleteSuccess] when deleteFood is successful',
      build: () {
        when(() => deleteFoodUseCase(any()))
            .thenAnswer((_) async => const Right(null));
        return foodCubit;
      },
      act: (cubit) => cubit.deleteFood(food: testFoodEntity),
      expect: () => <FoodState>[FoodDeleteInProgress(), FoodDeleteSuccess()],
    );

    // Exceptional case
    blocTest<FoodCubit, FoodState>(
      'emits [FoodDeleteInProgress, FoodFailure] when deleteFood is unsuccessful',
      build: () {
        when(() => deleteFoodUseCase(any()))
            .thenAnswer((_) async => Left(ServerFailure()));
        return foodCubit;
      },
      act: (cubit) => cubit.deleteFood(food: testFoodEntity),
      expect: () => <FoodState>[FoodDeleteInProgress(), FoodFailure()],
    );
  });

  group('getFoods unit tests', () {
    // Normal case
    blocTest<FoodCubit, FoodState>(
      'emits [FoodsLoadInProgress, FoodsLoadSuccess] when getFoods is successful',
      build: () {
        when(() => getFoodsUseCase()).thenAnswer((_) async => const Right([]));
        return foodCubit;
      },
      act: (cubit) => cubit.getFoods(),
      expect: () =>
          <FoodState>[FoodsLoadInProgress(), const FoodsLoadSuccess(foods: [])],
    );
  });

  // Exceptional case
  blocTest<FoodCubit, FoodState>(
    'emits [FoodsLoadInProgress, FoodFailure] when getFoods is unsuccessful',
    build: () {
      when(() => getFoodsUseCase()).thenAnswer((_) async => Left(ServerFailure()));
      return foodCubit;
    },
    act: (cubit) => cubit.getFoods(),
    expect: () =>
        <FoodState>[FoodsLoadInProgress(), FoodFailure()],
  );
}
