import 'package:proteam_app/features/food/domain/entities/food_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Food Data Model
class FoodModel extends FoodEntity {
  const FoodModel(
      {required super.name,
      required super.servingSize,
      required super.servingSizeUnit,
      required super.calories,
      required super.carbs,
      required super.protein,
      required super.fat});

  // Factory to create FoodModel instances from firebase snapshot data
  factory FoodModel.fromSnapshot(DocumentSnapshot snapshot) {
    final snap = snapshot.data() as Map<String, dynamic>;

    return FoodModel(
        name: snap['name'],
        servingSize: snap['servingSize'],
        servingSizeUnit: snap['servingSizeUnit'],
        calories: snap['calories'],
        carbs: snap['carbs'],
        protein: snap['protein'],
        fat: snap['fat']);
  }

  // Factory to create FoodModel instances from json (api calls)
  factory FoodModel.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'name': String name,
        'servingSize': int servingSize,
        'servingSizeUnit': String servingSizeUnit,
        'calories': int calories,
        'carbs': int carbs,
        'protein': int protein,
        'fat': int fat,
      } =>
        FoodModel(
          name: name,
          servingSize: servingSize,
          servingSizeUnit: servingSizeUnit,
          calories: calories,
          carbs: carbs,
          protein: protein,
          fat: fat
        ),
      _ => throw const FormatException('Failed to load FoodModel from json'),
    };
  }

  // Convert FoodModel to firebase document map
  Map<String, dynamic> toDocument() => {
        'name': name,
        'servingSize': servingSize,
        'servingSizeUnit': servingSizeUnit,
        'calories': calories,
        'carbs': carbs,
        'protein': protein,
        'fat': fat,
      };
}
