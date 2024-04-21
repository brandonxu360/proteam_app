import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:proteam_app/core/error/failures.dart';
import 'package:proteam_app/features/food/data/data_sources/food_remote_data_source.dart';
import 'package:proteam_app/features/food/data/models/food_model.dart';
import 'package:proteam_app/features/food/data/repositories/food_repository_impl.dart';
import 'package:proteam_app/features/food/domain/entities/food_entity.dart';

// Mock remote food datasource implementation
class MockFoodRemoteDataSourceImpl extends Mock
    implements FoodRemoteDataSource {}

// Food repository implementation tests
void main() {
  // The food repository implementation depends on the foodRemoteDataSource (abstraction)
  late FoodRemoteDataSource foodRemoteDataSource;
  late FoodRepositoryImpl foodRepositoryImpl;

  // Dummy food entity for the createFood group
  late FoodEntity testFoodEntity;

  setUp(() {
    foodRemoteDataSource = MockFoodRemoteDataSourceImpl();
    foodRepositoryImpl =
        FoodRepositoryImpl(foodRemoteDataSource: foodRemoteDataSource);
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

  // createFood method unit tests
  group('createFood unit tests', () {
    // Test the createFood method normal case - verify that it makes the expected call and returns the expected value
    test(
        'should call [RemoteDataSource.createFood] and complete successfully when the call to the remote source is successful',
        () async {
      // * Arrange

      // Set up the mock remote data source interaction - mock a successful call -> future void completion
      when(() => foodRemoteDataSource.createFood(any()))
          .thenAnswer((_) async => Future.value());

      // * Act
      final result = await foodRepositoryImpl.createFood(testFoodEntity);

      // * Assert

      // Assert that the expected call was executed with the expected arguments exactly once
      verify(() => foodRemoteDataSource.createFood(testFoodEntity)).called(1);

      // Assert a right value for successful completion
      expect(result, equals(const Right(null)));
    });

    // Test the createFood exceptional case - verify that it makes the expected call and returns the expected failure object
    test(
        'should call [RemoteDataSource.createFood] and return a [ServerFailure] when the call to the remote source is unsuccessful',
        () async {
      // * Arrange

      // Set up the mock remote data source interaction - mock an unsuccessful call -> exception thrown
      when(() => foodRemoteDataSource.createFood(any()))
          .thenThrow(Exception('Failed to create food'));

      // * Act
      final result = await foodRepositoryImpl.createFood(testFoodEntity);

      // * Assert

      // Assert that the expected call was executed with the expected arguments exactly once
      verify(() => foodRemoteDataSource.createFood(testFoodEntity)).called(1);

      // Assert that a left value [ServerFailure] was returned
      expect(result, equals(Left(ServerFailure())));
    });
  });

  // deleteFood method unit tests
  group('deleteFood unit tests', () {
    // Test the deleteFood method normal case - verify that it makes the expected call and returns the expected value
    test(
        'should call [RemoteDataSource.deleteFood] and complete successfully when the call to the remote source is successful',
        () async {
      // * Arrange

      // Set up the mock remote data source interaction - mock a successful call -> future void completion
      when(() => foodRemoteDataSource.deleteFood(any()))
          .thenAnswer((_) async => Future.value());

      // * Act
      final result = await foodRepositoryImpl.deleteFood(testFoodEntity);

      // * Assert

      // Assert that the expected call was executed with the expected arguments exactly once
      verify(() => foodRemoteDataSource.deleteFood(testFoodEntity)).called(1);

      // Assert a right value for successful completion
      expect(result, equals(const Right(null)));
    });

    // Test the deleteFood exceptional case - verify that it makes the expected call and returns the expected failure object
    test(
        'should call [RemoteDataSource.deleteFood] and return a [ServerFailure] when the call to the remote source is unsuccessful',
        () async {
      // * Arrange

      // Set up the mock remote data source interaction - mock an unsuccessful call -> exception thrown
      when(() => foodRemoteDataSource.deleteFood(any()))
          .thenThrow(Exception('Failed to delete food'));

      // * Act
      final result = await foodRepositoryImpl.deleteFood(testFoodEntity);

      // * Assert

      // Assert that the expected call was executed with the expected arguments exactly once
      verify(() => foodRemoteDataSource.deleteFood(testFoodEntity)).called(1);

      // Assert that a left value [ServerFailure] was returned
      expect(result, equals(Left(ServerFailure())));
    });
  });
}
