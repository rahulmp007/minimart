// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minimart/src/features/products/domain/params/product_query_params.dart';

import 'package:minimart/src/features/products/domain/usecases/fetch_products.dart';
import 'package:minimart/src/features/products/presentation/bloc/products/product_event.dart';
import 'package:minimart/src/features/products/presentation/bloc/products/product_state.dart';

class ProductBloc extends Bloc<ProductsEvent, ProductsState> {
  final FetchProducts fetchProducts;

  ProductBloc({required this.fetchProducts}) : super(ProductsState.initial()) {
    on<LoadProducts>(onFetchProducts);
    on<LoadMoreProducts>(onFetchMoreProducts);
    on<ApplyFilters>(onFiltersApply);
  }

  FutureOr<void> onFetchProducts(
    LoadProducts event,
    Emitter<ProductsState> emit,
  ) async {
    emit(state.copyWith(status: ProductsStatus.loading));
    final result = await fetchProducts.call(
      page: event.params.page,
      limit: event.params.limit,
    );
    result.fold(
      (failure) {
        emit(
          state.copyWith(
            status: ProductsStatus.error,
            errorMessage: failure.message,
          ),
        );
      },
      (products) {
        emit(
          state.copyWith(
            products: products,
            status: ProductsStatus.success,
            hasReachedEnd: products.length < event.params.limit,
          ),
        );
      },
    );
  }

  FutureOr<void> onFetchMoreProducts(
    LoadMoreProducts event,
    Emitter<ProductsState> emit,
  ) async {
    if (state.hasReachedEnd || state.status == ProductsStatus.loadingMore) {
      return;
    }

    emit(state.copyWith(status: ProductsStatus.loadingMore));
    final result = await fetchProducts.call(
      page: (state.params?.page ?? 0) + 1,
      limit: state.params?.limit ?? 10,
    );

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            products: state.products,
            status: ProductsStatus.ongoingError,
            errorMessage: failure.message,
          ),
        );
      },
      (products) {
        emit(
          state.copyWith(
            products: [...state.products, ...products],
            status: ProductsStatus.success,
            hasReachedEnd: products.length < (state.params?.limit ?? 10),
          ),
        );
      },
    );
  }

  FutureOr<void> onFiltersApply( 
    ApplyFilters event,
    Emitter<ProductsState> emit,
  ) {
    final queryParams = ProductQueryParams.initial();
    queryParams.copyWith(
      category: event.params.category,
      minPrice: event.params.minPrice,
      maxPrice: event.params.maxPrice,
      rating: event.params.rating,
      tags: event.params.tags,
      sortBy: event.params.sortBy,
    );
  }
}
