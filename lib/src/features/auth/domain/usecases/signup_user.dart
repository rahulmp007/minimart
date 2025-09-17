// lib/features/authentication/domain/usecases/signup_user.dart
import 'package:dartz/dartz.dart';
import 'package:minimart/src/core/error/failure.dart';
import 'package:minimart/src/features/auth/domain/entity/user.dart';
import 'package:minimart/src/features/auth/domain/repository/auth_repository.dart';

class SignupUser {
  final AuthRepository repository;
  SignupUser({required this.repository});

  Future<Either<Failure, User>> call({
    required String name,
    required String email,
    required String password,
  }) {
    return repository.signup(name: name, email: email, password: password);
  }
}
