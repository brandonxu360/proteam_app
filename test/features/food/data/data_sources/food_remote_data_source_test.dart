import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:proteam_app/features/food/data/data_sources/food_remote_data_source_impl.dart';
import 'package:proteam_app/features/food/data/models/food_model.dart';

// Food remote data source tests
void main() {
  late FakeFirebaseFirestore fakeFirebaseFirestore;
  late FoodRemoteDataSourceImpl foodRemoteDataSourceImpl;

  setUp(() {
    fakeFirebaseFirestore = FakeFirebaseFirestore();
    foodRemoteDataSourceImpl =
        FoodRemoteDataSourceImpl(firebaseFirestore: fakeFirebaseFirestore);
  });

  // CreateFood tests
  group('create food', () {
    test('should create a new food in Firestore', () async {
      // * Arrange
      const foodModel = FoodModel(
        name: 'Banana',
        servingSize: 1,
        servingSizeUnit: 'unit',
        calories: 110,
        carbs: 28,
        protein: 1,
        fat: 0,
      );

      // * Act
      await foodRemoteDataSourceImpl.createFood(foodModel);

      // * Assert
      final querySnapshot =
          await fakeFirebaseFirestore.collection('foods').get();
      final documents = querySnapshot.docs;

      // Assert that there is only one document in the collection
      expect(documents.length, 1);
      final data = documents[0].data();

      // Assert that the document holds the expected data
      expect(data, {
        'name': 'Banana',
        'servingSize': 1,
        'servingSizeUnit': 'unit',
        'calories': 110,
        'carbs': 28,
        'protein': 1,
        'fat': 0,
      });
    });

    // GetFoods tests
    group('get foods', () {
      test('should retrieve a list of foods from Firestore', () async {
        // * Arrange
        await fakeFirebaseFirestore.collection('foods').doc('doc1').set({
          'name': 'Apple',
          'servingSize': 1,
          'servingSizeUnit': 'unit',
          'calories': 120,
          'carbs': 25,
          'protein': 1,
          'fat': 0,
        });

        await fakeFirebaseFirestore.collection('foods').doc('doc2').set({
          'name': 'Banana',
          'servingSize': 1,
          'servingSizeUnit': 'unit',
          'calories': 110,
          'carbs': 28,
          'protein': 1,
          'fat': 0,
        });

        // * Act
        final foods = await foodRemoteDataSourceImpl.getFoods();

        // * Assert
        expect(foods.length, 2);
        expect(foods[0].name, 'Apple');
        expect(foods[1].name, 'Banana');
      });
    });

    // DeleteFood tests
    group('delete food', () {
      test('should delete a food from Firestore', () async {
        // * Arrange
        const foodModel = FoodModel(
          name: 'Banana',
          servingSize: 1,
          servingSizeUnit: 'unit',
          calories: 110,
          carbs: 28,
          protein: 1,
          fat: 0,
        );
        await fakeFirebaseFirestore.collection('foods').doc('doc1').set({
          'name': 'Apple',
          'servingSize': 1,
          'servingSizeUnit': 'unit',
          'calories': 120,
          'carbs': 25,
          'protein': 1,
          'fat': 0,
        });
        await fakeFirebaseFirestore.collection('foods').doc('doc2').set({
          'name': 'Banana',
          'servingSize': 1,
          'servingSizeUnit': 'unit',
          'calories': 110,
          'carbs': 28,
          'protein': 1,
          'fat': 0,
        });

        // Act
        await foodRemoteDataSourceImpl.deleteFood(foodModel);

        // Assert
        final snapshot = await fakeFirebaseFirestore
            .collection('foods')
            .doc('doc2')
            .get(); // Check if the doc2 is deleted
        expect(snapshot.exists, false);
      });
    });
  });
}
