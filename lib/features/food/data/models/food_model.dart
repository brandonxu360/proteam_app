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
    final name = json['description'] as String?;
    final servingSize = double.tryParse(json['servingSize'].toString());
    final servingSizeUnit = json['servingSizeUnit'] as String?;

    // Extracting nutrient values
    final foodNutrients = json['foodNutrients'] as List<dynamic>?;

    // Helper method to extract nutrient value by name
    double? extractNutrientValue(String nutrientName) {
      final nutrient = foodNutrients?.firstWhere(
        (nutrient) => nutrient['nutrientName'] == nutrientName,
        orElse: () => null,
      );
      return nutrient != null
          ? double.tryParse(nutrient['value'].toString())
          : null;
    }

    // Extract nutrient values
    final protein = extractNutrientValue('Protein');
    final fat = extractNutrientValue('Total lipid (fat)');
    final carbs = extractNutrientValue('Carbohydrate, by difference');
    final calories = extractNutrientValue('Energy');

    // Check if any of the required fields is missing
    if (name == null ||
        servingSize == null ||
        servingSizeUnit == null ||
        protein == null ||
        fat == null ||
        carbs == null ||
        calories == null) {
      throw const FormatException('Failed to load FoodModel from json');
    }

    return FoodModel(
      name: name,
      servingSize: servingSize,
      servingSizeUnit: servingSizeUnit,
      calories: calories,
      carbs: carbs,
      protein: protein,
      fat: fat,
    );
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
