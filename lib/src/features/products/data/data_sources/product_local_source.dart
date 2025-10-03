// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:minimart/src/core/service/local_storage.dart';
import 'package:minimart/src/features/products/domain/entity/product.dart';

abstract class ProductLocalSource {
  Future<List<Product>> fetchProducts();
}

class ProductLocalSourceImpl extends ProductLocalSource {
  final LocalStorageService localStorage;
  ProductLocalSourceImpl({required this.localStorage});

  @override
  Future<List<Product>> fetchProducts() {
    // TODO: implement fetchProducts
    throw UnimplementedError();
  }
}
