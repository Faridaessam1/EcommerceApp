import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/errors/failures.dart';
import 'package:injectable/injectable.dart';

import '../entities/subCategoryResponseEntity.dart';
import '../repositories/Subcategory/sub_category_interface.dart';
@injectable
class GetSubcategoriesUseCase {
  final SubcategoriesRepositoryInterface repository;

  GetSubcategoriesUseCase(this.repository);

  Future<Either<Failures, SubCategoryResponseEntity>> call({
    required String categoryId,
    int? page,
    int? limit,
  }) async {
    return await repository.getSubcategories(page: page, limit: limit);
  }
}