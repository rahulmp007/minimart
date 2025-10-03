import 'package:dartz/dartz.dart';
import 'package:minimart/src/core/error/failure.dart';
import 'package:minimart/src/features/products/domain/entity/product.dart';
import 'package:minimart/src/features/products/domain/repository/product_repository.dart';

class FetchProducts {
  final ProductRepository productRepo;

  FetchProducts({required this.productRepo});

  Future<Either<Failure, List<Product>>> call({
    required int page,
    required int limit,
  }) async {
    return await productRepo.getProducts(page: page, limit: limit);
  }
}
