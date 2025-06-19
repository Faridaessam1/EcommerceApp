import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/api/api_network.dart';
import 'package:e_commerce_app/core/api/end_points.dart';
import 'package:e_commerce_app/core/errors/failures.dart';
import 'package:e_commerce_app/domain/entities/ProductsResponseEntity.dart';
import 'package:e_commerce_app/data/model/products/ProductsResponseDM.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/repositories/dataSource/remote_interFace/products_remote_data_source.dart';

@Injectable(as: ProductsRemoteDataSource)
class ProductsRemoteDataSourceImpl implements ProductsRemoteDataSource {
  ApiNetwork apiNetwork;

  ProductsRemoteDataSourceImpl({required this.apiNetwork});

  @override
  Future<Either<Failures, ProductsResponseEntity>> getProductsBySubcategory(
      String subcategoryId, {
        int? page,
        int? limit,
      }) async {
    try {
      Map<String, dynamic> queryParams = {};

      if (page != null) {
        queryParams['page'] = page.toString();
      }
      if (limit != null) {
        queryParams['limit'] = limit.toString();
      }

      var response = await apiNetwork.getData(
        endPoint: '${EndPoints.productsEndPoint}/subcategory/$subcategoryId',
        queryParameters: queryParams.isNotEmpty ? queryParams : null,
      );

      final productsResponse = ProductsResponseDM.fromJson(response.data);

      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        // Convert DM to Entity
        final entity = ProductsResponseEntity(
          data: productsResponse.data?.map((productDM) =>
              ProductDataEntity(
                id: productDM.id,
                title: productDM.title,
                slug: productDM.slug,
                description: productDM.description,
                quantity: productDM.quantity,
                price: productDM.price,
                imageCover: productDM.imageCover,
                images: productDM.images,
                sold: productDM.sold,
                ratingsAverage: productDM.ratingsAverage,
                ratingsQuantity: productDM.ratingsQuantity,
                createdAt: productDM.createdAt,
                updatedAt: productDM.updatedAt,
                v: productDM.v,
                reviews: productDM.reviews,
                category: productDM.category != null
                    ? ProductCategoryResponseEntity(
                  id: productDM.category!.id,
                  name: productDM.category!.name,
                  slug: productDM.category!.slug,
                  image: productDM.category!.image,
                )
                    : null,
                brand: productDM.brand != null
                    ? ProductBrandResponseEntity(
                  id: productDM.brand!.id,
                  name: productDM.brand!.name,
                  slug: productDM.brand!.slug,
                  image: productDM.brand!.image,
                )
                    : null,
                subcategory: productDM.subcategory?.map((subCatDM) =>
                    ProductSubCategoryResponseEntity(
                      id: subCatDM.id,
                      name: subCatDM.name,
                      slug: subCatDM.slug,
                      category: subCatDM.category,
                    )
                ).toList(),
              )
          ).toList(),
        );

        return Right(entity);
      } else {
        return Left(ServerError(errorMsg: 'Failed to get products'));
      }
    } catch (error) {
      return Left(Failures(errorMsg: error.toString()));
    }
  }
}