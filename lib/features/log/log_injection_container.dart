import 'package:proteam_app/core/services/main_injection_container.dart';
import 'package:proteam_app/features/log/data/data_sources/log_remote_data_source.dart';
import 'package:proteam_app/features/log/data/data_sources/log_remote_data_source_impl.dart';
import 'package:proteam_app/features/log/data/repositories/log_repository_impl.dart';
import 'package:proteam_app/features/log/domain/repositories/log_repository.dart';
import 'package:proteam_app/features/log/domain/use_cases/get_day_food_usecase.dart';
import 'package:proteam_app/features/log/domain/use_cases/log_food_usecase.dart';
import 'package:proteam_app/features/log/presentation/cubit/day_meals/day_log_cubit.dart';
import 'package:proteam_app/features/log/presentation/cubit/food_log/food_log_cubit.dart';

Future<void> logInjectionContainer() async {
  // * Cubit Registration
  sl.registerFactory(() => FoodLogCubit(logFoodUseCase: sl.call()));

  sl.registerFactory(() => DayLogCubit(getDayFoodUseCase: sl.call()));

  // * Usecase Registration
  sl.registerLazySingleton(() => LogFoodUseCase(logRepository: sl.call()));

  sl.registerLazySingleton(
      () => GetMealsInDayUseCase(logRepository: sl.call()));

  // * Repository and Datasource Registration
  sl.registerLazySingleton<LogRepository>(
      () => LogRepositoryImpl(logRemoteDataSource: sl.call()));

  sl.registerLazySingleton<LogRemoteDataSource>(
      () => LogRemoteDataSourceImpl(firebaseFirestore: sl.call()));
}
