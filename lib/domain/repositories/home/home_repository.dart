import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/errors/failures.dart';
import 'package:e_commerce_app/domain/entities/category_response_entity.dart';

abstract class HomeRepository{
  Future<Either<Failures,CategoryResponseEntity>>getAllCategories();
}