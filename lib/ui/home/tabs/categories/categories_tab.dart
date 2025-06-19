import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_styles.dart';
import '../../../../core/di/di.dart';
import '../home/cubit/home_tab_states.dart';
import '../home/cubit/home_tab_view_model.dart';

class CategoriesTab extends StatefulWidget {
  @override
  State<CategoriesTab> createState() => _CategoriesTabState();
}

class _CategoriesTabState extends State<CategoriesTab> {
  HomeTabViewModel viewModel = getIt<HomeTabViewModel>();
  int selectedCategoryIndex = 0;
  int selectedSubCategoryIndex = 0;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          AppAssets.appLogo2,
          height: height * 0.25,
          width: width * 0.25,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: [
            // Left side - Categories List
            Expanded(
              flex: 2,
              child: BlocBuilder<HomeTabViewModel, HomeTabStates>(
                bloc: viewModel..getAllCategories(),
                builder: (BuildContext context, HomeTabStates state) {
                  if (state is CategoryLoadingState) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primaryColor,
                      ),
                    );
                  }
                  else if (state is CategoryErrorState) {
                    return Center(
                      child: Text(
                        "Something Went Wrong!",
                        style: AppStyles.W500White18.copyWith(color: Colors.red),
                        textAlign: TextAlign.center,
                      ),
                    );
                  }
                  else if (state is CategorySuccessState) {
                    return Container(
                      color: AppColors.babyBlue,
                      child: ListView.builder(
                        itemCount: state.categoryResponseEntity.categoryData?.length ?? 0,
                        itemBuilder: (context, index) {
                          bool isSelected = selectedCategoryIndex == index;
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedCategoryIndex = index;
                                selectedSubCategoryIndex = 0; // Reset subcategory selection
                              });
                              // Load subcategories for selected category
                              String? categoryId = state.categoryResponseEntity.categoryData![index].id;
                              if (categoryId != null) {
                                viewModel.getSubCategories(categoryId);
                              }
                            },
                            child: Container(
                              height: height * 0.1,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                  horizontal: 10
                              ),
                              color: isSelected
                                  ? AppColors.whiteColor
                                  : AppColors.babyBlue,
                              child: Center(
                                child: Text(
                                  state.categoryResponseEntity.categoryData![index].name ?? "",
                                  style: AppStyles.W400Blue14.copyWith(
                                    fontWeight: FontWeight.w500,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }
                  return Container();
                },
              ),
            ),

            // Middle - Subcategories List
            Expanded(
              flex: 2,
              child: BlocBuilder<HomeTabViewModel, HomeTabStates>(
                bloc: viewModel,
                builder: (context, state) {
                  if (state is SubCategoryLoadingState) {
                    return Container(
                      color: AppColors.babyBlue.withOpacity(0.3),
                      child: const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primaryColor,
                        ),
                      ),
                    );
                  }
                  else if (state is SubCategoryErrorState) {
                    return Container(
                      color: AppColors.babyBlue.withOpacity(0.3),
                      child: Center(
                        child: Text(
                          "No subcategories found",
                          style: AppStyles.W400Blue14,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  }
                  else if (state is SubCategorySuccessState) {
                    return Container(
                      color: AppColors.babyBlue.withOpacity(0.3),
                      child: ListView.builder(
                        itemCount: state.subCategoryResponseEntity.data?.length ?? 0,
                        itemBuilder: (context, index) {
                          bool isSelected = selectedSubCategoryIndex == index;
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedSubCategoryIndex = index;
                              });
                              // Load products for selected subcategory
                              String? subCategoryId = state.subCategoryResponseEntity.data![index].id;
                            },
                            child: Container(
                              height: height * 0.08,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                  horizontal: 8
                              ),
                              margin: const EdgeInsets.symmetric(vertical: 2),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? AppColors.whiteColor
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Center(
                                child: Text(
                                  state.subCategoryResponseEntity.data![index].name ?? "",
                                  style: AppStyles.W400Blue14.copyWith(
                                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                                    fontSize: 12,
                                  ),
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }

                  // Default state - show message to select category
                  return Container(
                    color: AppColors.babyBlue.withOpacity(0.3),
                    child: Center(
                      child: Text(
                        "Select a category\nto view subcategories",
                        style: AppStyles.W400Blue14.copyWith(
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                },
              ),
            ),

          ],
        ),
      ),
    );
  }
}