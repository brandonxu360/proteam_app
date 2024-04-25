class FoodEntryEntity {
  final String name;
  final int calories;
  final int carbs;
  final int protein;
  final int fat;

  // Note: for now, we will assume the same units as the servingSizeUnit of the FoodEntity it relates to
  final double quantity;
  final String quantityUnits;

  FoodEntryEntity(
      {required this.name,
      required this.calories,
      required this.carbs,
      required this.protein,
      required this.fat,
      required this.quantity,
      required this.quantityUnits});
}
