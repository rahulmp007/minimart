// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:minimart/src/core/error/failure.dart';
import 'package:minimart/src/features/products/data/data_sources/product_api_source.dart';
import 'package:minimart/src/features/products/data/mappers/product_mapper.dart';
import 'package:minimart/src/features/products/data/models/product_model.dart';
import 'package:minimart/src/features/products/domain/entity/product.dart';
import 'package:minimart/src/features/products/domain/repository/product_repository.dart';

class ProductRepositoryImpl extends ProductRepository {
  final ProductApiSource api;
  ProductRepositoryImpl({required this.api});

  @override
  Future<Either<Failure, List<Product>>> getProducts({
    required int page,
    required int limit,
  }) async {
    try {
      final data = await api.fetchProducts();
      final products = (data["products"] as List<dynamic>)
          .map((e) => ProductMapper.toEntity(model: ProductModel.fromJson(e)))
          .toList();

      // Pagination logic (take only required slice)
      final startIndex = (page - 1) * limit;
      final endIndex = startIndex + limit;

      if (startIndex >= products.length) return Right([]);

      return Right(
        products.sublist(
          startIndex,
          endIndex > products.length ? products.length : endIndex,
        ),
      );
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
