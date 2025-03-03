import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../entities/category_response_entity.dart';

abstract class HomeRemoteDataSource{
  Future<Either<Failures,CategoryResponseEntity>>getAllCategories();

}