import 'package:equatable/equatable.dart';

/// Represents a single food preset
/// ie. banana, dumpling, chicken pot pie
class FoodEntity extends Equatable {
  final String name;
  final int servingSize;
  final String servingSizeUnit;
  final int calories;
  final int carbs;
  final int protein;
  final int fat;

  const FoodEntity(
      {required this.name,
      required this.servingSize,
      required this.servingSizeUnit,
      required this.calories,
      required this.carbs,
      required this.protein,
      required this.fat});

  // Compare by name
  @override
  List<Object?> get props => [name];
}
