import 'package:dartz/dartz.dart';
import 'package:minimart/src/core/error/failure.dart';
import 'package:minimart/src/features/auth/domain/entity/user.dart';
import 'package:minimart/src/features/auth/domain/repository/auth_repository.dart';

class LoginUser {
  final AuthRepository repository;
  LoginUser({required this.repository});

  Future<Either<Failure, User>> call({
    required String email,
    required String password,
  }) {
    return repository.login(email: email, password: password);
  }
}
