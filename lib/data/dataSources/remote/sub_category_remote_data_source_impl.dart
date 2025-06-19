import 'package:dartz/dartz.dart';

import 'package:e_commerce_app/core/errors/failures.dart';

import 'package:e_commerce_app/domain/entities/subCategoryResponseEntity.dart';

import '../../../core/api/api_network.dart';
import '../../../core/api/end_points.dart';
import '../../../domain/repositories/dataSource/remote_interFace/sub_category_data_source_interface.dart';
import '../../model/subCategories/sub_category_response_data_model.dart';

class SubcategoriesRemoteDataSourceImpl implements SubcategoriesRemoteDataSource{
  ApiNetwork apiNetwork;
  SubcategoriesRemoteDataSourceImpl({required this.apiNetwork});

  @override
  Future<Either<Failures, SubCategoryResponseEntity>> getSubcategories({
    int? page,
    int? limit
  }) async {
    try {
      Map<String, dynamic>? queryParams;

      if (page != null || limit != null) {
        queryParams = {};
        if (page != null) queryParams['page'] = page;
        if (limit != null) queryParams['limit'] = limit;
      }

      var response = await apiNetwork.getData(
        endPoint: EndPoints.subCategoriesEndPoint, // هتحتاج تضيف ده في EndPoints
        queryParameters: queryParams,
      );

      final subCategoriesResponse = SubCategoryResponseDataModel.fromJson(response.data);

      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return Right(subCategoriesResponse);
      } else {
        return Left(ServerError(errorMsg: subCategoriesResponse.message ?? 'Server Error'));
      }
    } catch (error) {
      return Left(Failures(errorMsg: error.toString()));
    }
  }

  @override
  Future<Either<Failures, SubCategoryResponseEntity>> getSubcategoriesByCategory(
      String categoryId, {
        int? page,
        int? limit
      }) async {
    try {
      Map<String, dynamic>? queryParams;

      if (page != null || limit != null) {
        queryParams = {};
        if (page != null) queryParams['page'] = page;
        if (limit != null) queryParams['limit'] = limit;
      }

      var response = await apiNetwork.getData(
        endPoint: '${EndPoints.getAllCategoriesEndPoint}/$categoryId/subcategories',
        queryParameters: queryParams,
      );

      final subCategoriesResponse = SubCategoryResponseDataModel.fromJson(response.data);

      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return Right(subCategoriesResponse);
      } else {
        return Left(ServerError(errorMsg: subCategoriesResponse.message ?? 'Server Error'));
      }
    } catch (error) {
      return Left(Failures(errorMsg: error.toString()));
    }
  }

  @override
  Future<Either<Failures, SubCategoryDataEntity>> getSubcategoryById(String id) async {
    try {
      var response = await apiNetwork.getData(
        endPoint: '${EndPoints.subCategoriesEndPoint}/$id',
      );

      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        final subCategoryData = SubCategoryDataDataModel.fromJson(response.data['data']);
        return Right(subCategoryData);
      } else {
        final errorModel = SubCategoryResponseDataModel.fromJson(response.data);
        return Left(ServerError(errorMsg: errorModel.message ?? 'Server Error'));
      }
    } catch (error) {
      return Left(Failures(errorMsg: error.toString()));
    }
  }
}

