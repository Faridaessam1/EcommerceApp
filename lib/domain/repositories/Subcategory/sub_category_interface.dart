import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/errors/failures.dart';

import '../../entities/subCategoryResponseEntity.dart';

abstract class SubcategoriesRepositoryInterface {
  Future<Either<Failures, SubCategoryResponseEntity>> getSubcategories({
    int? page,
    int? limit,
  });

  Future<Either<Failures, SubCategoryResponseEntity>> getSubcategoriesByCategory(
      String categoryId, {
        int? page,
        int? limit,
      });

  Future<Either<Failures, SubCategoryDataEntity>> getSubcategoryById(String id);
}

