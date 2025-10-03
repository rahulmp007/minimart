import 'package:equatable/equatable.dart';
import 'package:minimart/src/features/products/domain/entity/product.dart';
import 'package:minimart/src/features/products/domain/params/product_query_params.dart';

enum ProductsStatus {
  initial,
  loading,
  success,
  error,
  loadingMore,
  ongoingError,
}

class ProductsState extends Equatable {
  final List<Product> products;
  final ProductsStatus status;
  final bool hasReachedEnd;
  final String? errorMessage;
  final ProductQueryParams? params;
  const ProductsState({
    required this.products,
    required this.status,
    required this.hasReachedEnd,
    this.errorMessage,
    this.params,
  });

  ProductsState copyWith({
    List<Product>? products,
    bool? hasReachedEnd,
    ProductsStatus? status,
    String? errorMessage,
    ProductQueryParams? params,
  }) => ProductsState(
    products: products ?? this.products,
    hasReachedEnd: hasReachedEnd ?? this.hasReachedEnd,
    status: status ?? this.status,
    errorMessage: errorMessage,
    params: params ?? this.params,
  );

  factory ProductsState.initial() => ProductsState(
    products: [],
    status: ProductsStatus.initial,
    hasReachedEnd: false,
  );

  @override
  List<Object?> get props => [
    products,
    status,
    hasReachedEnd,
    errorMessage,
    params,
  ];
}
