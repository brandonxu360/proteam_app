import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:proteam_app/features/food/data/data_sources/food_remote_data_source.dart';
import 'package:proteam_app/features/food/data/models/food_model.dart';
import 'package:proteam_app/features/food/data/repositories/food_repository_impl.dart';

// Mock remote food datasource implementation
class MockFoodRemoteDataSourceImpl extends Mock
    implements FoodRemoteDataSource {}

// Food repository implementation tests
void main() {
  late FoodRemoteDataSource foodRemoteDataSource;
  late FoodRepositoryImpl foodRepositoryImpl;

  setUp(() {
    foodRemoteDataSource = MockFoodRemoteDataSourceImpl();
    foodRepositoryImpl =
        FoodRepositoryImpl(foodRemoteDataSource: foodRemoteDataSource);
  });

  setUpAll(() {
    registerFallbackValue(const FoodModel(
      name: 'Dummy',
      servingSize: 0,
      servingSizeUnit: 'unit',
      calories: 0,
      carbs: 0,
      protein: 0,
      fat: 0,
    ));
  });

  group('createFood', () {
    test(
        'should call the [RemoteDataSource.createFood] and complete successfully when the call to the remote source is successful',
        () async {

          // * Arrange
          FoodModel testFoodEntity = const FoodModel(
                name: 'Banana',
                servingSize: 1,
                servingSizeUnit: 'unit',
                calories: 110,
                carbs: 28,
                protein: 1,
                fat: 0);

          // Set up the mock remote datasource interaction
          when(() => foodRemoteDataSource.createFood(any())).thenAnswer((_) async => Future.value());

          // * Act
          final result = await foodRepositoryImpl.createFood(testFoodEntity);

          // * Assert 

          // Assert a right value for successful completion
          expect(result, equals(const Right(null)));

          // Assert that the expected call was executed with the expected arguments exactly once
          verify(() => foodRemoteDataSource.createFood(testFoodEntity)).called(1);
        });
  });
}
