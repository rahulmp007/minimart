import 'package:minimart/src/core/service/local_storage.dart';
import 'package:minimart/src/features/auth/data/mappers/user_mapper.dart';
import 'package:minimart/src/features/auth/data/models/user_model.dart';
import 'package:minimart/src/features/auth/domain/entity/user.dart';

abstract class AuthLocalDataSource {
  Future<void> cacheUser({required UserModel user});
  Future<User?> getCachedUser();
  Future<void> clearUser();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final LocalStorageService localStorage;

  static const _authBox = 'authBox';
  static const _cachedUserKey = 'CACHED_USER';

  AuthLocalDataSourceImpl({required this.localStorage});

  @override
  Future<void> cacheUser({required UserModel user}) async {
    await localStorage.openBox<UserModel>(_authBox);
    await localStorage.put(_authBox, _cachedUserKey, user);
  }

  @override
  Future<User?> getCachedUser() async {
    await localStorage.openBox<UserModel>(_authBox);
    final model = await localStorage.get<UserModel>(_authBox, _cachedUserKey);
    return model != null ? UserMapper.toEntity(model) : null;
  }

  @override
  Future<void> clearUser() async {
    await localStorage.delete<UserModel>(_authBox, _cachedUserKey);
  }
}
