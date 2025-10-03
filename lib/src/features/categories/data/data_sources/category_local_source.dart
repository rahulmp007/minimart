import 'package:minimart/src/core/service/local_storage.dart';
import 'package:minimart/src/features/categories/data/models/category_model.dart';
import 'package:minimart/src/features/categories/domain/entity/category.dart';

abstract class CategoryLocalSource {
  Future<List<Category>> getCategories();
  Future<void> cacheCategories({required List<CategoryModel> categories});
}

class CategoryLocalSourceImpl extends CategoryLocalSource {
  final LocalStorageService localStorage;

  CategoryLocalSourceImpl({required this.localStorage});

  static const _categoryBox = 'categoriesBox';
  static const _cachedCategoriesKey = 'CACHED_CATEGORIES';
  @override
  Future<List<Category>> getCategories() async {
    return await localStorage.getAll(_categoryBox);
  }

  @override
  Future<void> cacheCategories({
    required List<CategoryModel> categories,
  }) async {
    // Clear old data before caching new list (optional, depends on use case)
    final box = await localStorage.openBox<CategoryModel>(_categoryBox);
    await box.clear();

    // Save all categories
    await localStorage.addAll<CategoryModel>(_categoryBox, categories);
  }
}
