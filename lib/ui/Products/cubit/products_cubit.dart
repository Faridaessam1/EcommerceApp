import 'package:e_commerce_app/ui/Products/cubit/products_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/useCases/get_products_by_subCategory_use_case.dart';


@injectable
class ProductCubit extends Cubit<ProductStates> {
  final GetProductsBySubCategoryUseCase getProductsBySubCategoryUseCase;

  ProductCubit({required this.getProductsBySubCategoryUseCase})
      : super(ProductInitialState());

  static ProductCubit get(context) => BlocProvider.of(context);

  List<dynamic> allProducts = [];
  int currentPage = 1;
  bool hasMoreProducts = true;
  String? currentSubcategoryId;

  void getProductsBySubCategory(String subcategoryId, {bool isRefresh = false}) async {
    if (isRefresh) {
      currentPage = 1;
      hasMoreProducts = true;
      allProducts.clear();
      currentSubcategoryId = subcategoryId;
    }

    if (currentPage == 1) {
      emit(ProductLoadingState());
    } else {
      emit(ProductLoadMoreState());
    }

    var result = await getProductsBySubCategoryUseCase.call(
      subcategoryId,
      page: currentPage,
      limit: 10,
    );

    result.fold(
          (error) {
        if (currentPage == 1) {
          emit(ProductErrorState(errorMsg: error.errorMsg));
        } else {
          emit(ProductLoadMoreErrorState(errorMsg: error.errorMsg));
        }
      },
          (response) {
        if (response.data != null && response.data!.isNotEmpty) {
          if (currentPage == 1) {
            allProducts = response.data!;
          } else {
            allProducts.addAll(response.data!);
          }

          // Check if we have more products to load
          if (response.data!.length < 10) {
            hasMoreProducts = false;
          }

          currentPage++;

          if (currentPage == 2) { // First load
            emit(ProductSuccessState(productsResponse: response));
          } else {
            emit(ProductLoadMoreSuccessState(productsResponse: response));
          }
        } else {
          hasMoreProducts = false;
          if (currentPage == 1) {
            emit(ProductSuccessState(productsResponse: response));
          } else {
            emit(ProductLoadMoreSuccessState(productsResponse: response));
          }
        }
      },
    );
  }

  void loadMoreProducts() {
    if (hasMoreProducts && currentSubcategoryId != null) {
      getProductsBySubCategory(currentSubcategoryId!, isRefresh: false);
    }
  }

  void refreshProducts() {
    if (currentSubcategoryId != null) {
      getProductsBySubCategory(currentSubcategoryId!, isRefresh: true);
    }
  }
}
