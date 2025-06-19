import 'package:e_commerce_app/domain/entities/category_response_entity.dart';
import 'package:e_commerce_app/domain/useCases/get_all_categories_use_case.dart';
import 'package:e_commerce_app/ui/home/tabs/home/cubit/home_tab_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/constants/app_assets.dart';
import '../../../../../domain/entities/subCategoryResponseEntity.dart';
import '../../../../../domain/useCases/get_sub_categories_use_case.dart';

@injectable
class HomeTabViewModel extends Cubit<HomeTabStates> {
  GetAllCategoriesUseCase getAllCategoriesUseCase;
  GetSubcategoriesUseCase getSubCategoriesUseCase;

  HomeTabViewModel({
    required this.getAllCategoriesUseCase,
    required this.getSubCategoriesUseCase,
  }) : super(HomeTabInitialState());

  final List<String> adsImages = [
    AppAssets.ad3,
    AppAssets.ad2,
    AppAssets.ad1,
  ];

  List<CategoryDataEntity> categoriesList = [];
  List<SubCategoryDataEntity> subCategoriesList = [];

  // Get all categories
  getAllCategories() async {
    emit(CategoryLoadingState());
    var response = await getAllCategoriesUseCase.call();
    response.fold((error) {
      emit(CategoryErrorState(failures: error));
    }, (response) {
      categoriesList = response.categoryData ?? [];
      emit(CategorySuccessState(categoryResponseEntity: response));
    });
  }

  // Get all subcategories (or by category ID)
  void getAllSubcategories(String categoryId, {int? page, int? limit}) async {
    emit(SubCategoryLoadingState());

    var response = await getSubCategoriesUseCase.call(
      categoryId: categoryId,
      page: page,
      limit: limit,
    );

    response.fold(
          (error) => emit(SubCategoryErrorState(failures: error)),
          (response) => emit(SubCategorySuccessState(subCategoryResponseEntity: response)),
    );
  }

  // Get subcategories by category ID (redundant with getAllSubcategories)
  void getSubCategories(String categoryId, {int? page, int? limit}) async {
    emit(SubCategoryLoadingState());

    var response = await getSubCategoriesUseCase.call(
      categoryId: categoryId,
      page: page,
      limit: limit,
    );

    response.fold(
          (error) => emit(SubCategoryErrorState(failures: error)),
          (response) => emit(SubCategorySuccessState(subCategoryResponseEntity: response)),
    );
  }
}
