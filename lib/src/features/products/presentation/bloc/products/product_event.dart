// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:minimart/src/features/products/domain/params/product_query_params.dart';

sealed class ProductsEvent extends Equatable {
  const ProductsEvent();

  @override
  List<Object?> get props => [];
}

class LoadProducts extends ProductsEvent {
  final ProductQueryParams params;

  const LoadProducts({required this.params});

  @override
  List<Object?> get props => [params];
}

class LoadMoreProducts extends ProductsEvent {
  const LoadMoreProducts();

  @override
  List<Object?> get props => [];
}

class ApplyFilters extends ProductsEvent {
  final ProductQueryParams params;
  const ApplyFilters({required this.params});

  @override
  List<Object?> get props => [params];
}
