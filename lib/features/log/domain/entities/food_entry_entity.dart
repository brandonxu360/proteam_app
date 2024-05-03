class FoodEntryEntity {
  final String name;
  final String? brand;
  final double calories;
  final double carbs;
  final double protein;
  final double fat;
  final double servingSize;
  final String servingSizeUnit;

  final double actualCalories;
  final double actualCarbs;
  final double actualProtein;
  final double actualFat;
  // Note: for now, we will assume the same units as the servingSizeUnit of the FoodEntity it relates to
  final double quantity;
  final String quantityUnits;

  FoodEntryEntity(
      {required this.name,
      this.brand,
      required this.calories,
      required this.carbs,
      required this.protein,
      required this.fat,
      required this.servingSize,
      required this.servingSizeUnit,
      required this.quantity,
      required this.quantityUnits,
      required this.actualCalories,
      required this.actualCarbs,
      required this.actualFat,
      required this.actualProtein});
}
