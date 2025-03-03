import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/errors/failures.dart';
import 'package:e_commerce_app/domain/entities/category_response_entity.dart';
import 'package:e_commerce_app/domain/repositories/dataSource/remote_interFace/home_remote_data_source.dart';
import 'package:e_commerce_app/domain/repositories/home/home_repository.dart';
import 'package:injectable/injectable.dart';
@Injectable(as:HomeRepository)
class HomeRepositoryImpl implements HomeRepository{
  HomeRemoteDataSource homeRemoteDataSource;

  HomeRepositoryImpl({required this.homeRemoteDataSource});

  @override
  Future<Either<Failures, CategoryResponseEntity>> getAllCategories() async{
   var response = await homeRemoteDataSource.getAllCategories();
   return response.fold(
         (error) =>Left(error),
         (response) =>Right(response),);
  }

}