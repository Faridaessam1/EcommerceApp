import 'package:e_commerce_app/domain/entities/category_response_entity.dart';
import '../../../../../core/errors/failures.dart';
import '../../../../../domain/entities/subCategoryResponseEntity.dart';

abstract class HomeTabStates {}

class HomeTabInitialState extends HomeTabStates {}

// Category States
class CategoryLoadingState extends HomeTabStates {}

class CategoryErrorState extends HomeTabStates {
  Failures failures;
  CategoryErrorState({required this.failures});
}

class CategorySuccessState extends HomeTabStates {
  CategoryResponseEntity categoryResponseEntity;
  CategorySuccessState({required this.categoryResponseEntity});
}

// Subcategory States
class SubCategoryInitialState extends HomeTabStates {}

class SubCategoryLoadingState extends HomeTabStates {}

class SubCategorySuccessState extends HomeTabStates {
  SubCategoryResponseEntity subCategoryResponseEntity;
  SubCategorySuccessState({required this.subCategoryResponseEntity});
}

class SubCategoryErrorState extends HomeTabStates {
  Failures failures;
  SubCategoryErrorState({required this.failures});
}
class SubCategoryEmptyState extends HomeTabStates {
}

