import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:proteam_app/features/food/data/data_sources/food_remote_data_source.dart';
import 'package:proteam_app/features/food/data/models/food_model.dart';

class FoodRemoteDataSourceImpl extends FoodRemoteDataSource {
  // Instance of the firebase firestore that will be used to make the api calls
  final FirebaseFirestore firebaseFirestore;

  FoodRemoteDataSourceImpl({required this.firebaseFirestore});

  // Persist a food model in foods collection
  @override
  Future<void> createFood(FoodModel food) async {
    try {
      // Convert food model to firestore-compatible map
      final foodMap = food.toDocument();

      // Add the food to the foods collection
      await firebaseFirestore.collection('foods').add(foodMap);
    } catch (e) {
      // Handle any errors here
      throw Exception('Failed to create food');
    }
  }

  // Delete a food model from food collection
  @override
  Future<void> deleteFood(FoodModel food) async {
    try {
      final querySnapshot = await firebaseFirestore
          .collection('foods')
          .where('name', isEqualTo: food.name)
          .get();
      final doc = querySnapshot.docs.first;
      await doc.reference.delete();
    } catch (e) {
      throw Exception('Failed to delete food: $e');
    }
  }

  @override
  Future<List<FoodModel>> getFoods() async {
    try {
      final querySnapshot = await firebaseFirestore.collection('foods').get();
      return querySnapshot.docs
          .map((doc) => FoodModel.fromSnapshot(doc))
          .toList();
    } catch (e) {
      throw Exception('Failed to get foods: $e');
    }
  }

}