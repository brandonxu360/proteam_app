import 'package:dartz/dartz.dart';
import 'package:proteam_app/core/error/failures.dart';
import 'package:proteam_app/features/user/domain/entities/user_entity.dart';
import 'package:proteam_app/features/user/domain/repositories/user_repository.dart';

class CreateUserUseCase {
  final UserRepository repository;

  CreateUserUseCase({required this.repository});

  Future<Either<Failure, void>> call(UserEntity user) async {
    return repository.createUser(user);
  }
}