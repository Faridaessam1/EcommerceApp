import '../../../domain/entities/ProductsResponseEntity.dart';

abstract class ProductStates {}

class ProductInitialState extends ProductStates {}

class ProductLoadingState extends ProductStates {}

class ProductSuccessState extends ProductStates {
  final ProductsResponseEntity productsResponse;
  ProductSuccessState({required this.productsResponse});
}

class ProductErrorState extends ProductStates {
  final String errorMsg;
  ProductErrorState({required this.errorMsg});
}

class ProductLoadMoreState extends ProductStates {}

class ProductLoadMoreSuccessState extends ProductStates {
  final ProductsResponseEntity productsResponse;
  ProductLoadMoreSuccessState({required this.productsResponse});
}

class ProductLoadMoreErrorState extends ProductStates {
  final String errorMsg;
  ProductLoadMoreErrorState({required this.errorMsg});
}
