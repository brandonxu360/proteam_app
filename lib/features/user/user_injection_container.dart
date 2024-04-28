import 'package:proteam_app/core/services/main_injection_container.dart';
import 'package:proteam_app/features/user/data/data_sources/user_remote_data_source.dart';
import 'package:proteam_app/features/user/data/data_sources/user_remote_data_source_impl.dart';
import 'package:proteam_app/features/user/data/repositories/user_repository_impl.dart';
import 'package:proteam_app/features/user/domain/repositories/user_repository.dart';
import 'package:proteam_app/features/user/domain/use_cases/auth/get_current_uid_usecase.dart';
import 'package:proteam_app/features/user/domain/use_cases/auth/is_signed_in_usecase.dart';
import 'package:proteam_app/features/user/domain/use_cases/auth/register_with_email_usecase.dart';
import 'package:proteam_app/features/user/domain/use_cases/auth/sign_in_with_email_usecase.dart';
import 'package:proteam_app/features/user/domain/use_cases/auth/sign_out_usecase.dart';
import 'package:proteam_app/features/user/domain/use_cases/user/create_user_usecase.dart';
import 'package:proteam_app/features/user/domain/use_cases/user/get_single_user_usecase.dart';
import 'package:proteam_app/features/user/presentation/cubit/auth/auth_cubit.dart';
import 'package:proteam_app/features/user/presentation/cubit/user/user_cubit.dart';

Future<void> userInjectionContainer() async {
  // * Cubit Registration
  sl.registerFactory<AuthCubit>(() => AuthCubit(
      getCurrentUidUseCase: sl.call(),
      isSignedInUseCase: sl.call(),
      signOutUseCase: sl.call(),
      registerWithEmail: sl.call(),
      createUserUseCase: sl.call(),
      signInWithEmailUseCase: sl.call()));

  sl.registerFactory<UserCubit>(() => UserCubit(getSingleUserUseCase: sl.call()));

  // * Use case injection

  sl.registerLazySingleton(() => GetCurrentUidUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => IsSignedInUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => RegisterWithEmailUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => SignInWithEmailUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => SignOutUseCase(repository: sl.call()));

  sl.registerLazySingleton(() => CreateUserUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => GetSingleUserUseCase(repository: sl.call()));

  // * Repository and Data Source injection
  sl.registerLazySingleton<UserRepository>(
      () => UserRepositoryImpl(userRemoteDataSource: sl.call()));

  sl.registerLazySingleton<UserRemoteDataSource>(() => UserRemoteDataSourceImpl(
      firebaseAuth: sl.call(), firebaseFirestore: sl.call()));
}
