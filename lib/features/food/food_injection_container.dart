import 'package:proteam_app/core/services/main_injection_container.dart';
import 'package:proteam_app/features/food/data/data_sources/food_remote_data_source.dart';
import 'package:proteam_app/features/food/data/data_sources/food_remote_data_source_impl.dart';
import 'package:proteam_app/features/food/data/repositories/food_repository_impl.dart';
import 'package:proteam_app/features/food/domain/repositories/food_repository.dart';
import 'package:proteam_app/features/food/domain/usecases/create_food_usecase.dart';
import 'package:proteam_app/features/food/domain/usecases/delete_food_usecase.dart';
import 'package:proteam_app/features/food/domain/usecases/get_foods_usecase.dart';
import 'package:proteam_app/features/food/presentation/cubit/food_cubit.dart';

Future<void> foodInjectionContainer() async {
  // * Cubit Registration
  sl.registerFactory(() => FoodCubit(
      createFoodUseCase: sl.call(),
      deleteFoodUseCase: sl.call(),
      getFoodsUseCase: sl.call()));

  // * Usecase Registration
  sl.registerLazySingleton(() => CreateFoodUseCase(foodRepository: sl.call()));
  sl.registerLazySingleton(() => DeleteFoodUseCase(foodRepository: sl.call()));
  sl.registerLazySingleton(() => GetFoodsUseCase(foodRepository: sl.call()));

  // * Repository and Data Source Registration
  sl.registerLazySingleton<FoodRepository>(() => FoodRepositoryImpl(foodRemoteDataSource: sl.call()));

  sl.registerLazySingleton<FoodRemoteDataSource>(() => FoodRemoteDataSourceImpl(firebaseFirestore: sl.call()));
}


