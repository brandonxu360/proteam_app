import 'package:proteam_app/features/food/domain/entities/food_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Food Data Model
class FoodModel extends FoodEntity {
  const FoodModel(
      {super.brand,
      required super.name,
      required super.servingSize,
      required super.servingSizeUnit,
      required super.calories,
      required super.carbs,
      required super.protein,
      required super.fat});

  // Create a FoodEntity instances from the food model
  FoodEntity toFoodEntity() {
    return FoodEntity(
        name: name,
        brand: brand,
        servingSize: servingSize,
        servingSizeUnit: servingSizeUnit,
        calories: calories,
        carbs: carbs,
        protein: protein,
        fat: fat);
  }

  // Factory to create FoodModel instances from firebase snapshot data
  factory FoodModel.fromSnapshot(DocumentSnapshot snapshot) {
    final snap = snapshot.data() as Map<String, dynamic>;

    return FoodModel(
        name: snap['name'],
        brand: snap['brand'],
        servingSize: snap['servingSize'],
        servingSizeUnit: snap['servingSizeUnit'],
        calories: snap['calories'],
        carbs: snap['carbs'],
        protein: snap['protein'],
        fat: snap['fat']);
  }

  // Factory to create FoodModel instances from json (api calls) - currently only supports Branded and FNDDS datatypes
  factory FoodModel.fromJson(Map<String, dynamic> json) {
    final dataType = json['dataType'];

    if (dataType == 'Survey (FNDDS)') {
      // Handle FNDDS data type
      return FoodModel.fromFNDDSJson(json);
    } else if (dataType == 'Branded') {
      // Handle Branded data type
      return FoodModel.fromBrandedJson(json);
    } else {
      throw Exception('Unrecognized json format');
    }
  }

  factory FoodModel.fromFNDDSJson(Map<String, dynamic> json) {
    // Parse JSON specific to FNDDS data type and return a FoodModel instance
    try {
      // Extract the nutrient values
      final nutrientValues = json['foodNutrients'] as List<dynamic>;

      final calories = double.parse(nutrientValues
          .firstWhere((nutrient) => nutrient['nutrientName'] == 'Energy')['value'].toString());
      final carbs = double.parse(nutrientValues.firstWhere((nutrient) =>
          nutrient['nutrientName'] == 'Carbohydrate, by difference')['value'].toString());
      final protein = double.parse(nutrientValues
          .firstWhere((nutrient) => nutrient['nutrientName'] == 'Protein')['value'].toString());
      final fat = double.parse(nutrientValues.firstWhere(
          (nutrient) => nutrient['nutrientName'] == 'Total lipid (fat)')['value'].toString());

      // The serving sizes for FNDDS nutrients is 100 g
      const servingSize = 100.0;
      const servingSizeUnit = 'g';

      // Populate fields specific to FNDDS data type
      return FoodModel(
          name: json['description'],
          servingSize: servingSize,
          servingSizeUnit: servingSizeUnit,
          calories: calories,
          carbs: carbs,
          protein: protein,
          fat: fat);
    } catch (e) {
      throw Exception('Error parsing FNDDS json: $e');
    }
  }

  factory FoodModel.fromBrandedJson(Map<String, dynamic> json) {
    // Parse JSON specific to Branded data type and return a FoodModel instance
    try {
      // Extract the nutrient values
      final nutrientValues = json['foodNutrients'] as List<dynamic>;

      final calories = double.parse(nutrientValues
          .firstWhere((nutrient) => nutrient['nutrientName'] == 'Energy')['value'].toString());
      final carbs = double.parse(nutrientValues.firstWhere(
          (nutrient) => nutrient['nutrientName'] == 'Carbohydrate, by difference')['value'].toString());
      final protein = double.parse(nutrientValues
          .firstWhere((nutrient) => nutrient['nutrientName'] == 'Protein')['value'].toString());
      final fat = double.parse(nutrientValues
          .firstWhere((nutrient) => nutrient['nutrientName'] == 'Total lipid (fat)')['value'].toString());

      // Populate fields specific to Branded data type
      return FoodModel(
          name: json['description'],
          brand: json['brandName'],
          servingSize: double.parse(json['servingSize'].toString()),
          servingSizeUnit: json['servingSizeUnit'],
          calories: calories,
          carbs: carbs,
          protein: protein,
          fat: fat);
    } catch (e) {
      throw Exception('Error parsing Branded json: $e');
    }
  }

  // Convert FoodModel to firebase document map
  Map<String, dynamic> toDocument() => {
        'name': name,
        'brand': brand,
        'servingSize': servingSize,
        'servingSizeUnit': servingSizeUnit,
        'calories': calories,
        'carbs': carbs,
        'protein': protein,
        'fat': fat,
      };
}
