import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:proteam_app/features/food/data/data_sources/food_remote_data_source.dart';
import 'package:proteam_app/features/food/data/models/food_model.dart';
import 'package:proteam_app/core/const/firebase_collection_const.dart';
import 'package:proteam_app/features/food/domain/entities/food_entity.dart';

class FoodRemoteDataSourceImpl extends FoodRemoteDataSource {
  // Instance of the firebase firestore that will be used to make the api calls
  final FirebaseFirestore firebaseFirestore;

  FoodRemoteDataSourceImpl({required this.firebaseFirestore});

  // Persist a food model in foods collection
  @override
  Future<void> createFood(FoodEntity food) async {
    try {
      // Convert food entity to firestore-compatible map
      final foodMap = FoodModel(
          name: food.name,
          servingSize: food.servingSize,
          servingSizeUnit: food.servingSizeUnit,
          calories: food.calories,
          carbs: food.carbs,
          protein: food.protein,
          fat: food.fat).toDocument();

      // Add the food to the foods collection
      await firebaseFirestore
          .collection(FirebaseCollectionConst.foods)
          .add(foodMap);
    } catch (e) {
      // Handle any errors here
      throw Exception('Failed to create food');
    }
  }

  // Delete a food model from food collection
  @override
  Future<void> deleteFood(FoodEntity food) async {
    try {
      final querySnapshot = await firebaseFirestore
          .collection(FirebaseCollectionConst.foods)
          .where('name', isEqualTo: food.name)
          .get();
      final doc = querySnapshot.docs.first;
      await doc.reference.delete();
    } catch (e) {
      throw Exception('Failed to delete food: $e');
    }
  }

  // Get the list of persisted foods
  @override
  Future<List<FoodEntity>> getFoods() async {
    try {
      final querySnapshot = await firebaseFirestore
          .collection(FirebaseCollectionConst.foods)
          .get();

      // Implicit upcast to FoodEntity
      return querySnapshot.docs
          .map((doc) => FoodModel.fromSnapshot(doc))
          .toList();
    } catch (e) {
      throw Exception('Failed to get foods: $e');
    }
  }
}
