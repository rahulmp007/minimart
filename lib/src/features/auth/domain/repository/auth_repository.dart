import 'package:dartz/dartz.dart';
import 'package:minimart/src/core/error/failure.dart';
import 'package:minimart/src/features/auth/domain/entity/user.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> login({
    required String email,
    required String password,
  });

  Future<Either<Failure, User>> signup({
    required String name,
    required String email,
    required String password,
  });

  Future<Either<Failure, void>> logout();

  Future<Either<Failure, User?>> getCurrentUser();
}
