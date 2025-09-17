// lib/features/authentication/data/repositories/auth_repository_impl.dart
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:minimart/src/core/error/failure.dart';
import 'package:minimart/src/features/auth/data/data_sources/auth_api_source.dart';
import 'package:minimart/src/features/auth/data/data_sources/auth_local_source.dart';
import 'package:minimart/src/features/auth/data/mappers/user_mapper.dart';
import 'package:minimart/src/features/auth/data/models/user_model.dart';
import 'package:minimart/src/features/auth/domain/entity/user.dart';
import 'package:minimart/src/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthApiService api;
  final AuthLocalDataSource local;
  AuthRepositoryImpl({required this.api, required this.local});

  @override
  Future<Either<Failure, User>> login({
    required String email,
    required String password,
  }) async {
    try {
      final data = await api.login(email, password);
      final userModel = UserModel.fromJson(data);
      await local.cacheUser(user: userModel);
      return Right(UserMapper.toEntity(userModel));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final data = await api.signup(name, email, password);
      final userModel = UserModel.fromJson(data);
      return Right(UserMapper.toEntity(userModel));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await local.clearUser();
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(message: "Logout failed: $e"));
    }
  }

  @override
  Future<Either<Failure, User?>> getCurrentUser() async {
    try {
      User? currentUser = await local.getCachedUser();
      if (kDebugMode) {
        log('cached user : ${currentUser.toString()}');
      }
      return Right(currentUser);
    } catch (e) {
      return Left(CacheFailure(message: "Failed to get current user: $e"));
    }
  }
}
