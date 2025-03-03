import 'package:e_commerce_app/core/errors/failures.dart';
import 'package:e_commerce_app/domain/entities/category_response_entity.dart';

abstract class HomeTabStates{}
class HomeTabInitialState extends HomeTabStates{}
class CategoryLoadingState extends HomeTabStates{}
class CategorySuccessState extends HomeTabStates{
  CategoryResponseEntity categoryResponseEntity;

  CategorySuccessState({required this.categoryResponseEntity});
}
class CategoryErrorState extends HomeTabStates{
  Failures failures;

  CategoryErrorState({required this.failures});
}