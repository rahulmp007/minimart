// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:minimart/src/features/categories/domain/entity/category.dart';

sealed class CategoriesEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadCategories extends CategoriesEvent {}

class ChangeCategory extends CategoriesEvent {
  final Category category;
  ChangeCategory({required this.category});

  @override
  List<Object?> get props => [category];
}
