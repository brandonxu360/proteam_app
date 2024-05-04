import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:proteam_app/features/log/domain/entities/food_entry_entity.dart';

class FoodEntryModel extends FoodEntryEntity {
  FoodEntryModel(
      {required super.name,
      required super.calories,
      required super.carbs,
      required super.protein,
      required super.fat,
      required super.quantity,
      required super.quantityUnits,
      required super.actualCalories,
      required super.actualCarbs,
      required super.actualFat,
      required super.actualProtein,
      required super.servingSize,
      required super.servingSizeUnit});

  // Method to convert a FoodEntryModel instance to a Map
  Map<String, dynamic> toDocument() => {
        'name': name,
        'calories': calories,
        'carbs': carbs,
        'protein': protein,
        'fat': fat,
        'quantity': quantity,
        'quantityUnits': quantityUnits,
        'actualCalories': actualCalories,
        'actualCarbs': actualCarbs,
        'actualFat': actualFat,
        'actualProtein': actualProtein,
        'servingSize': servingSize,
        'servingSizeUnit': servingSizeUnit,
      };

  // Static method to create a FoodEntryModel instance from a Firestore document snapshot
  factory FoodEntryModel.fromSnapshot(DocumentSnapshot snapshot) {
    var data = snapshot.data() as Map<String, dynamic>;
    return FoodEntryModel(
      name: data['name'],
      calories: data['calories'],
      carbs: data['carbs'],
      protein: data['protein'],
      fat: data['fat'],
      quantity: data['quantity'],
      quantityUnits: data['quantityUnits'],
      actualCalories: data['actualCalories'],
      actualCarbs: data['actualCarbs'],
      actualFat: data['actualFat'],
      actualProtein: data['actualProtein'],
      servingSize: data['servingSize'],
      servingSizeUnit: data['servingSizeUnit'],
    );
  }

  // Conversion method to convert FoodEntryEntity instance to FoodEntryModel
  factory FoodEntryModel.fromEntity(FoodEntryEntity entity) {
    return FoodEntryModel(
      name: entity.name,
      calories: entity.calories,
      carbs: entity.carbs,
      protein: entity.protein,
      fat: entity.fat,
      quantity: entity.quantity,
      quantityUnits: entity.quantityUnits,
      actualCalories: entity.actualCalories,
      actualCarbs: entity.actualCarbs,
      actualFat: entity.actualFat,
      actualProtein: entity.actualProtein,
      servingSize: entity.servingSize,
      servingSizeUnit: entity.servingSizeUnit,
    );
  }

  // Conversion method to convert FoodEntryModel instance to FoodEntryEntity
  FoodEntryEntity toEntity() {
    return FoodEntryEntity(
      name: name,
      calories: calories,
      carbs: carbs,
      protein: protein,
      fat: fat,
      quantity: quantity,
      quantityUnits: quantityUnits,
      actualCalories: actualCalories,
      actualCarbs: actualCarbs,
      actualFat: actualFat,
      actualProtein: actualProtein,
      servingSize: servingSize,
      servingSizeUnit: servingSizeUnit,
    );
  }
}
