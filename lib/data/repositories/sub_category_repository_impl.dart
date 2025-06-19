import 'package:dartz/dartz.dart';

import 'package:e_commerce_app/core/errors/failures.dart';

import 'package:e_commerce_app/domain/entities/subCategoryResponseEntity.dart';

import '../../domain/repositories/Subcategory/sub_category_interface.dart';
import '../../domain/repositories/dataSource/remote_interFace/sub_category_data_source_interface.dart';

class SubcategoriesRepositoryImpl implements SubcategoriesRepositoryInterface {
  SubcategoriesRemoteDataSource subcategoriesRemoteDataSource;
  SubcategoriesRepositoryImpl({required this.subcategoriesRemoteDataSource});
  @override
  Future<Either<Failures, SubCategoryResponseEntity>> getSubcategories({int? page, int? limit}) async{
    var response = await subcategoriesRemoteDataSource.getSubcategories();
    return response.fold( 
          (error) =>Left(error),
          (response) =>Right(response),
    );
    
  }

  @override
  Future<Either<Failures, SubCategoryResponseEntity>> getSubcategoriesByCategory(String categoryId, {int? page, int? limit}) async {
    var response = await subcategoriesRemoteDataSource.getSubcategoriesByCategory(categoryId);
    return response.fold(
          (error) =>Left(error),
          (response) =>Right(response),
    );
  }

  @override
  Future<Either<Failures, SubCategoryDataEntity>> getSubcategoryById(String id) async{
    var response = await subcategoriesRemoteDataSource.getSubcategoryById(id);
    return response.fold(
          (error) =>Left(error),
          (response) =>Right(response),
    );
  }
  
}
