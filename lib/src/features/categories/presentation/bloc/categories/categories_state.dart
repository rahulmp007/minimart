// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:minimart/src/features/categories/domain/entity/category.dart';

sealed class CategoriesState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CategoriesInitial extends CategoriesState {}

class CategoriesLoading extends CategoriesState {}

class CategoriesSuccess extends CategoriesState {
  final List<Category> categories;
  final String? currentSelected;
  final int? currentSelectedIndex;
  CategoriesSuccess({
    required this.categories,
    this.currentSelected,
    this.currentSelectedIndex,
  });

  @override
  List<Object?> get props => [
    categories,
    currentSelected,
    currentSelectedIndex,
  ];
}

class CategoriesError extends CategoriesState {
  final String errorMessage;
  CategoriesError({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
