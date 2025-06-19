import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/errors/failures.dart';
import 'package:e_commerce_app/domain/entities/ProductsResponseEntity.dart';
import 'package:injectable/injectable.dart';

import '../../domain/repositories/dataSource/remote_interFace/products_remote_data_source.dart';
import '../../domain/repositories/products/products_repository_interface.dart';

@Injectable(as: ProductsRepositoryInterface)
class ProductsRepositoryImpl implements ProductsRepositoryInterface {
  ProductsRemoteDataSource productsRemoteDataSource;

  ProductsRepositoryImpl({required this.productsRemoteDataSource});

  @override
  Future<Either<Failures, ProductsResponseEntity>> getProductsBySubcategory(
      String subcategoryId, {
        int? page,
        int? limit,
      }) async {
    var response = await productsRemoteDataSource.getProductsBySubcategory(
      subcategoryId,
      page: page,
      limit: limit,
    );
    return response.fold(
          (error) => Left(error),
          (response) => Right(response),
    );
  }
}