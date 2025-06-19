import 'package:dartz/dartz.dart';

import 'package:e_commerce_app/core/errors/failures.dart';

import 'package:e_commerce_app/domain/entities/subCategoryResponseEntity.dart';
import 'package:injectable/injectable.dart';

import '../../domain/repositories/Subcategory/sub_category_interface.dart';
import '../../domain/repositories/dataSource/remote_interFace/sub_category_data_source_interface.dart';
@Injectable(as: SubcategoriesRepositoryInterface)
class SubcategoriesRepositoryImpl implements SubcategoriesRepositoryInterface {
  SubcategoriesRemoteDataSource subcategoriesRemoteDataSource;
  SubcategoriesRepositoryImpl({required this.subcategoriesRemoteDataSource});

  @override
  Future<Either<Failures, SubCategoryResponseEntity>> getSubcategories({int? page, int? limit}) async{
    // Fixed: Pass the parameters to the data source
    var response = await subcategoriesRemoteDataSource.getSubcategories(page: page, limit: limit);
    return response.fold(
          (error) => Left(error),
          (response) => Right(response),
    );
  }

  @override
  Future<Either<Failures, SubCategoryResponseEntity>> getSubcategoriesByCategory(String categoryId, {int? page, int? limit}) async {
    // Fixed: Pass the parameters to the data source
    var response = await subcategoriesRemoteDataSource.getSubcategoriesByCategory(categoryId, page: page, limit: limit);
    return response.fold(
          (error) => Left(error),
          (response) => Right(response),
    );
  }

  @override
  Future<Either<Failures, SubCategoryDataEntity>> getSubcategoryById(String id) async{
    var response = await subcategoriesRemoteDataSource.getSubcategoryById(id);
    return response.fold(
          (error) => Left(error),
          (response) => Right(response),
    );
  }
}
