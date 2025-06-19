import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/domain/repositories/products/products_repository_interface.dart';
import 'package:injectable/injectable.dart';

import '../../core/errors/failures.dart';
import '../entities/ProductsResponseEntity.dart';

@injectable
class GetProductsBySubCategoryUseCase {
  ProductsRepositoryInterface productsRepositoryInterface;

  GetProductsBySubCategoryUseCase({required this.productsRepositoryInterface});

  Future<Either<Failures, ProductsResponseEntity>> call(
      String subcategoryId, {
        int? page,
        int? limit,
      }) {
    return productsRepositoryInterface.getProductsBySubcategory(
      subcategoryId,
      page: page,
      limit: limit,
    );
  }
}