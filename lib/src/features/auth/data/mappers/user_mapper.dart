// lib/features/auth/data/mappers/user_mapper.dart
import 'package:minimart/src/features/auth/data/models/user_model.dart';
import 'package:minimart/src/features/auth/domain/entity/user.dart';

class UserMapper {
  static UserModel fromEntity(User entity) {
    return UserModel(id: entity.id, name: entity.name, email: entity.email);
  }

  static User toEntity(UserModel model) {
    return User(id: model.id, name: model.name, email: model.email);
  }

  // For lists
  static List<UserModel> fromEntityList(List<User> entities) {
    return entities.map(fromEntity).toList();
  }

  static List<User> toEntityList(List<UserModel> models) {
    return models.map(toEntity).toList();
  }
}
