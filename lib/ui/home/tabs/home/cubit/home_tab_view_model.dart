import 'package:e_commerce_app/domain/entities/category_response_entity.dart';
import 'package:e_commerce_app/domain/useCases/get_all_categories_use_case.dart';
import 'package:e_commerce_app/ui/home/tabs/home/cubit/home_tab_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:e_commerce_app/core/errors/failures.dart';
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

  // في الـ HomeTabViewModel

  void getSubCategories(String categoryId, {int? page, int? limit}) async {
    try {
      print("🔍 ViewModel: Starting getSubCategories for categoryId: $categoryId");
      print("🔍 ViewModel: page: $page, limit: $limit");

      emit(SubCategoryLoadingState());

      var response = await getSubCategoriesUseCase.call(
        categoryId: categoryId,
        page: page,
        limit: limit,
      );

      print("🔍 ViewModel: UseCase response received");

      response.fold(
            (error) {
          print("❌ ViewModel: Error from UseCase: $error");
          print("❌ ViewModel: Error type: ${error.runtimeType}");
          print("❌ ViewModel: Error message: ${error.errorMsg}");
          emit(SubCategoryErrorState(failures: error));
        },
            (response) {
          print("✅ ViewModel: Success from UseCase");
          print("✅ ViewModel: Response data: ${response.data?.length} items");
          print("✅ ViewModel: Response: $response");
          emit(SubCategorySuccessState(subCategoryResponseEntity: response));
        },
      );
    } catch (e, stackTrace) {
      print("💥 ViewModel: Exception in getSubCategories: $e");
      print("📍 ViewModel: Stack trace: $stackTrace");
      // Create a generic failure or emit error state
      emit(SubCategoryErrorState(failures: ServerError(errorMsg: e.toString())));
    }
  }
}
