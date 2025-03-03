import 'package:e_commerce_app/domain/entities/category_response_entity.dart';
import 'package:e_commerce_app/domain/useCases/get_all_categories_use_case.dart';
import 'package:e_commerce_app/ui/home/tabs/home/cubit/home_tab_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/constants/app_assets.dart';
@injectable
class HomeTabViewModel extends Cubit<HomeTabStates> {
  GetAllCategoriesUseCase getAllCategoriesUseCase;

  HomeTabViewModel({required this.getAllCategoriesUseCase})
      : super(HomeTabInitialState());
  final List<String> adsImages = [
    AppAssets.ad3,
    AppAssets.ad2,
    AppAssets.ad1,
  ];

  List<CategoryDataEntity> categoriesList = [];
  getAllCategories() async {
    emit(CategoryLoadingState());
    var response = await getAllCategoriesUseCase.call();
    response.fold((error) {
      emit(
        CategoryErrorState(failures: error),
      );
    }, (response) {
      categoriesList = response.categoryData!;
      emit(
        CategorySuccessState(categoryResponseEntity: response),
      );
    });
  }
}
