import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/api/end_points.dart';

import 'package:e_commerce_app/core/errors/failures.dart';
import 'package:e_commerce_app/data/model/categories/category_response_data_model.dart';

import 'package:e_commerce_app/domain/entities/category_response_entity.dart';
import 'package:injectable/injectable.dart';

import '../../../core/api/api_network.dart';
import '../../../domain/repositories/dataSource/remote_interFace/home_remote_data_source.dart';
@Injectable(as:HomeRemoteDataSource )
class HomeRemoteDataSourceImpl implements HomeRemoteDataSource{
  ApiNetwork apiNetwork;

  HomeRemoteDataSourceImpl({required this.apiNetwork});

  @override
  Future<Either<Failures, CategoryResponseEntity>> getAllCategories() async {
    try{
      var response = await apiNetwork.getData(
        endPoint: EndPoints.getAllCategoriesEndPoint,
      );
      var categoryResponse = CategoryResponseDataModel.fromJson(response.data);
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return Right(categoryResponse);
      } else {
        return Left(ServerError(errorMsg: categoryResponse.message!));
      }
    }catch (error) {
      return Left(Failures(errorMsg: error.toString()));
    }

}

}