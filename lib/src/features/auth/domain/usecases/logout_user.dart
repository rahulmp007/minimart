// lib/features/authentication/domain/usecases/logout_user.dart
import 'package:dartz/dartz.dart';
import 'package:minimart/src/core/error/failure.dart';
import 'package:minimart/src/features/auth/domain/repository/auth_repository.dart';

class LogoutUser {
  final AuthRepository repository;
  LogoutUser({required this.repository});

  Future<Either<Failure, void>> call()async {
    return await repository.logout();
  }
}
