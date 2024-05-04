import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:proteam_app/core/const/firebase_collection_const.dart';
import 'package:proteam_app/core/const/meal_const.dart';
import 'package:proteam_app/core/utils/date_helpers.dart';
import 'package:proteam_app/features/log/data/data_sources/log_remote_data_source.dart';
import 'package:proteam_app/features/log/data/models/food_entry_model.dart';
import 'package:proteam_app/features/log/domain/entities/food_entry_entity.dart';
import 'package:proteam_app/features/log/domain/entities/meal_entry_entity.dart';

class LogRemoteDataSourceImpl implements LogRemoteDataSource {
  // Instance of the firebase firestore that will be used to make the api calls
  final FirebaseFirestore firebaseFirestore;

  LogRemoteDataSourceImpl({required this.firebaseFirestore});

  @override
  Future<List<MealEntryEntity>> getMealsInDay(String date, String uid) async {
    try {
      // Encode the date
      String encodedDate = encodeDateForFirestore(date);

      // Create a reference to the user's log collection
      final userLogRef = firebaseFirestore
          .collection(FirebaseCollectionConst.users)
          .doc(uid)
          .collection(FirebaseCollectionConst.log);

      // Create a reference to the date document inside the log collection
      final dateDocRef = userLogRef.doc(encodedDate);

      // Get all meal collection references for the specified date
      final breakfastCollectionRef = dateDocRef.collection(MealConst.breakfast);
      final lunchCollectionRef = dateDocRef.collection(MealConst.lunch);
      final dinnerCollectionRef = dateDocRef.collection(MealConst.dinner);

      // List to hold meal entries
      List<MealEntryEntity> meals = [];

      // Iterate through each meal collection and get the food entries
      for (final mealCollectionRef in [
        breakfastCollectionRef,
        lunchCollectionRef,
        dinnerCollectionRef
      ]) {
        // Get the food entries for the meal
        final foodEntries = await mealCollectionRef.get();

        // Create a list of food entry entities from the food entries
        List<FoodEntryEntity> foodEntryEntities = foodEntries.docs
            .map((foodEntry) =>
                FoodEntryModel.fromSnapshot(foodEntry).toEntity())
            .toList();

        // Create a meal entry entity from the food entries
        MealEntryEntity meal = MealEntryEntity(
            mealType: mealCollectionRef.id, foodEntries: foodEntryEntities);

        // Add the meal to the list of meals
        meals.add(meal);
      }

      return meals;
    } catch (e) {
      // Handle errors here, such as Firestore exceptions or other exceptions
      print('Error getting meals: $e');
      // Throw or handle errors as needed
      rethrow;
    }
  }

  @override
  Future<void> logMeal(MealEntryEntity meal) {
    // TODO: implement logMeal
    throw UnimplementedError();
  }

  @override
  Future<void> logFood(
      FoodEntryEntity food, String date, String mealType, String uid) async {
    try {
      // Encode the date
      String encodedDate = encodeDateForFirestore(date);

      // Create a reference to the user's log collection
      final userLogRef = firebaseFirestore
          .collection(FirebaseCollectionConst.users)
          .doc(uid)
          .collection(FirebaseCollectionConst.log);

      // Create a reference to the date document inside the log collection
      final dateDocRef = userLogRef.doc(encodedDate);

      // Create a reference to the meal type document inside the date document
      final mealTypeDocRef = dateDocRef.collection(mealType);

      // Add the food entry to the collection inside the meal type document
      await mealTypeDocRef.add(FoodEntryModel.fromEntity(food).toDocument());

      // Add a timestamp field to the date document
      await dateDocRef.set(
          {
            'timestamp': FieldValue
                .serverTimestamp(), // FieldValue.serverTimestamp() generates a server-side timestamp
          },
          SetOptions(
              merge:
                  true)); // Use merge option to avoid overwriting existing fields
    } catch (e) {
      // Handle errors here, such as Firestore exceptions or other exceptions
      print('Error logging food: $e');
      // You can throw custom exceptions or handle them as needed
    }
  }
}
