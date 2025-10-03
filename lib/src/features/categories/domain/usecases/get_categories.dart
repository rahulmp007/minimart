import 'package:dartz/dartz.dart';
import 'package:minimart/src/core/error/failure.dart';
import 'package:minimart/src/features/categories/domain/entity/category.dart';
import 'package:minimart/src/features/categories/domain/repository/category_repository.dart';

class GetCategories {
  final CategoryRepository categoryRepository;
  GetCategories({required this.categoryRepository});

  Future<Either<Failure, List<Category>>> call() async {
    return await categoryRepository.getCategories();
  }
}
