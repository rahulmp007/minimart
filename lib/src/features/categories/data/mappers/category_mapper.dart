// lib/features/category/data/mappers/category_mapper.dart
import 'package:minimart/src/features/categories/data/models/category_model.dart';
import 'package:minimart/src/features/categories/domain/entity/category.dart';

class CategoryMapper {
  /// Map from domain entity → data model
  static CategoryModel fromEntity(Category entity) {
    return CategoryModel(
      id: entity.id,
      name: entity.name,
      iconUrl: entity.iconUrl,
    );
  }

  /// Map from data model → domain entity
  static Category toEntity(CategoryModel model) {
    return Category(id: model.id, name: model.name, iconUrl: model.iconUrl);
  }

  /// For lists
  static List<CategoryModel> fromEntityList(List<Category> entities) {
    return entities.map(fromEntity).toList();
  }

  static List<Category> toEntityList(List<CategoryModel> models) {
    return models.map(toEntity).toList();
  }
}
