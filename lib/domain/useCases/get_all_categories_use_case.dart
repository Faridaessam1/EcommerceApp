import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/domain/repositories/home/home_repository.dart';
import 'package:injectable/injectable.dart';
import '../../core/errors/failures.dart';
import '../entities/category_response_entity.dart';
@injectable
class GetAllCategoriesUseCase{
  HomeRepository homeRepository;

  GetAllCategoriesUseCase({required this.homeRepository});

  Future<Either<Failures,CategoryResponseEntity>> call(){
  return homeRepository.getAllCategories();
}

}