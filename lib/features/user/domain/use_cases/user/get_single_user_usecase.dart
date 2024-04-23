import 'package:dartz/dartz.dart';
import 'package:proteam_app/core/error/failures.dart';
import 'package:proteam_app/features/user/domain/entities/user_entity.dart';
import 'package:proteam_app/features/user/domain/repositories/user_repository.dart';

class GetSingleUserUseCase {
  final UserRepository repository;

  GetSingleUserUseCase({required this.repository});

  Future<Either<Failure, Stream<List<UserEntity>>>> call(String uid) async {
    return repository.getSingleUser(uid);
  }
}