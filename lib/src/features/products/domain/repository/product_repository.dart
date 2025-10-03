import 'package:dartz/dartz.dart';
import 'package:minimart/src/core/error/failure.dart';
import 'package:minimart/src/features/products/domain/entity/product.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<Product>>> getProducts({required int page,required int limit});
}
