import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:proteam_app/features/food/food_injection_container.dart';

// Main service locator instance
final sl = GetIt.instance;

Future<void> init() async {
  final fireStore = FirebaseFirestore.instance;

  // Register in main IC because they will be used across features
  sl.registerLazySingleton(() => fireStore);

  await foodInjectionContainer();
}