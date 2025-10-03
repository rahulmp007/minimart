// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:dartz/dartz.dart';

import 'package:minimart/src/core/error/failure.dart';
import 'package:minimart/src/features/categories/data/data_sources/category_api_source.dart';
import 'package:minimart/src/features/categories/data/data_sources/category_local_source.dart';
import 'package:minimart/src/features/categories/data/mappers/category_mapper.dart';
import 'package:minimart/src/features/categories/data/models/category_model.dart';
import 'package:minimart/src/features/categories/domain/entity/category.dart';
import 'package:minimart/src/features/categories/domain/repository/category_repository.dart';

class CategoryRepositoryImpl extends CategoryRepository {
  final CategoryApiSource api;
  final CategoryLocalSource localSource;
  CategoryRepositoryImpl({required this.api, required this.localSource});
  @override
  Future<Either<Failure, List<Category>>> getCategories() async {
    try {
      final data = await api.fetchCategories();
      log('data : $data');
      final categoriesModel = (data as List<dynamic>)
          .map((e) => CategoryModel.fromMap(e))
          .toList();
      await localSource.cacheCategories(categories: categoriesModel);
      return Right(CategoryMapper.toEntityList(categoriesModel));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
