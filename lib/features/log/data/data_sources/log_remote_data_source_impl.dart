import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:proteam_app/core/const/firebase_collection_const.dart';
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
  Future<List<MealEntryEntity>> getMealsInDay(String date) {
    // TODO: implement getMealsInDay
    throw UnimplementedError();
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

      // If you want, you can return something here, like the document ID of the added food entry
      // You can also handle errors, if any
    } catch (e) {
      // Handle errors here, such as Firestore exceptions or other exceptions
      print('Error logging food: $e');
      // You can throw custom exceptions or handle them as needed
    }
  }
}
