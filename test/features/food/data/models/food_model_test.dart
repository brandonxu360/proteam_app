import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:proteam_app/features/food/data/models/food_model.dart';
import 'package:proteam_app/features/food/domain/entities/food_entity.dart';

// FoodModel tests
void main() {
  late FoodModel testFoodModel;

  setUpAll(() {
    testFoodModel = const FoodModel(
        name: 'Banana',
        servingSize: 1,
        servingSizeUnit: 'unit',
        calories: 110,
        carbs: 28,
        protein: 1,
        fat: 0);
  });

  // Test that the model is an extension of the entity
  test('should be a subclass of food entity', () async {
    // * Assert
    expect(testFoodModel, isA<FoodEntity>());
  });

  // Test the model -> firestore doc map conversion
  test(
      'should return a firestore doc map containing the expected data from model',
      () {
    // * Arrange
    final Map<String, dynamic> expected = {
      'name': 'Banana',
      'brand': null,
      'servingSize': 1,
      'servingSizeUnit': 'unit',
      'calories': 110,
      'carbs': 28,
      'protein': 1,
      'fat': 0
    };

    // * Act
    final Map<String, dynamic> result = testFoodModel.toDocument();

    // * Assert
    expect(result, equals(expected));
  });

  // Test the firestore snapshot -> model conversion
  test('should return a valid model from firebase snapshot', () async {
    // * Arrange

    // Use a firestore fake to create a fake snapshot
    final firestore = FakeFirebaseFirestore();
    final collection = firestore.collection('foods');
    const documentId = 'test_food_id';

    // Add data to the snapshot
    await collection.doc(documentId).set({
      'name': 'Banana',
      'servingSize': 1.0,
      'servingSizeUnit': 'unit',
      'calories': 110.0,
      'carbs': 28.0,
      'protein': 1.0,
      'fat': 0.0,
    });

    // Retrieve the snapshot after the data is set
    final snapshot = await collection.doc(documentId).get();

    // * Act
    final result = FoodModel.fromSnapshot(snapshot);

    // * Assert
    final foodModelMatcher = isA<FoodModel>();

    // Manually assert each field because FoodModel only checks name property for equality through equatable
    expect(result,
        foodModelMatcher.having((model) => model.name, 'name', 'Banana'));
    expect(
        result,
        foodModelMatcher.having(
            (model) => model.servingSize, 'servingSize', 1));
    expect(
        result,
        foodModelMatcher.having(
            (model) => model.servingSizeUnit, 'servingSizeUnit', 'unit'));
    expect(result,
        foodModelMatcher.having((model) => model.calories, 'calories', 110));
    expect(
        result, foodModelMatcher.having((model) => model.carbs, 'carbs', 28));
    expect(result,
        foodModelMatcher.having((model) => model.protein, 'protein', 1));
    expect(result, foodModelMatcher.having((model) => model.fat, 'fat', 0));
  });
}
