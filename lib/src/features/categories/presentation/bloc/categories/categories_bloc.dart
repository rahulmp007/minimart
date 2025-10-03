import 'dart:async';
import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minimart/src/features/categories/domain/entity/category.dart';
import 'package:minimart/src/features/categories/domain/usecases/get_categories.dart';
import 'package:minimart/src/features/categories/presentation/bloc/categories/categories_event.dart';
import 'package:minimart/src/features/categories/presentation/bloc/categories/categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  final GetCategories getCategories;

  CategoriesBloc({required this.getCategories}) : super(CategoriesInitial()) {
    on<LoadCategories>(_fetchCategories);
    on<ChangeCategory>(_changeCategory);
  }

  FutureOr<void> _fetchCategories(
    LoadCategories event,
    Emitter<CategoriesState> emit,
  ) async {
    emit(CategoriesLoading());
    final result = await getCategories.call();
    result.fold(
      (failure) {
        emit(CategoriesError(errorMessage: failure.message));
      },
      (categoryList) {
        emit(CategoriesSuccess(categories: categoryList));
        emit(
          CategoriesSuccess(
            categories: categoryList,
            currentSelected: categoryList.first.id,
            currentSelectedIndex: 0,
          ),
        );
      },
    );
  }

  FutureOr<void> _changeCategory(
    ChangeCategory event,
    Emitter<CategoriesState> emit,
  ) async {
    if (state is CategoriesSuccess) {
      final currentState = state as CategoriesSuccess;
      final List<Category> categories = currentState.categories;
      final selectedIndex = categories.indexWhere(
        (c) => c.id == event.category.id,
      );

      log('selected index : $selectedIndex');

      emit(
        CategoriesSuccess(
          categories: categories,
          currentSelected: event.category.id,
          currentSelectedIndex: selectedIndex,
        ),
      );
    }
  }
}
