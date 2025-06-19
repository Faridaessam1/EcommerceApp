import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../entities/ProductsResponseEntity.dart';

abstract class ProductsRemoteDataSource {
  // Get products by subcategory
  Future<Either<Failures, ProductsResponseEntity>> getProductsBySubcategory(
      String subcategoryId, {
        int? page,
        int? limit,
      });

}