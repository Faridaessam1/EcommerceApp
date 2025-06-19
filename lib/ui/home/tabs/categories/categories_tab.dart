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
  late HomeTabViewModel viewModel;
  late HomeTabViewModel subCategoryViewModel;
  int selectedCategoryIndex = 0;
  int selectedSubCategoryIndex = 0;
  bool isFirstLoad = true;
  List<dynamic>? categoriesData;

  @override
  void initState() {
    super.initState();
    // Initialize ViewModels
    viewModel = getIt<HomeTabViewModel>();
    subCategoryViewModel = getIt<HomeTabViewModel>();

    // Load categories once
    viewModel.getAllCategories();
  }

  @override
  void dispose() {
    // Clean up if needed
    super.dispose();
  }

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
              child: BlocConsumer<HomeTabViewModel, HomeTabStates>(
                bloc: viewModel,
                listener: (context, state) {
                  // Handle side effects here if needed
                  if (state is CategoryErrorState) {
                    print("Category Error: ${state.toString()}");
                  }
                },
                builder: (BuildContext context, HomeTabStates state) {
                  print("Categories State: ${state.runtimeType}"); // Debug

                  if (state is CategoryLoadingState) {
                    return Container(
                      color: AppColors.babyBlue,
                      child: const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primaryColor,
                        ),
                      ),
                    );
                  }
                  else if (state is CategoryErrorState) {
                    return Container(
                      color: AppColors.babyBlue,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Something Went Wrong!",
                              style: AppStyles.W500White18.copyWith(color: Colors.red),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: () {
                                viewModel.getAllCategories(); // Retry
                              },
                              child: Text("Retry"),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  else if (state is CategorySuccessState) {
                    // Save categories data
                    categoriesData = state.categoryResponseEntity.categoryData;
                    print("Categories loaded: ${categoriesData?.length}"); // Debug

                    // Auto-load first category's subcategories on first load
                    if (isFirstLoad && categoriesData != null && categoriesData!.isNotEmpty) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        isFirstLoad = false;
                        String? firstCategoryId = categoriesData![0].id;
                        if (firstCategoryId != null) {
                          print("Loading subcategories for: $firstCategoryId"); // Debug
                          subCategoryViewModel.getSubCategories(firstCategoryId);
                        }
                      });
                    }

                    if (categoriesData == null || categoriesData!.isEmpty) {
                      return Container(
                        color: AppColors.babyBlue,
                        child: Center(
                          child: Text(
                            "No categories available",
                            style: AppStyles.W400Blue14,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    }

                    return Container(
                      color: AppColors.babyBlue,
                      child: ListView.builder(
                        itemCount: categoriesData!.length,
                        itemBuilder: (context, index) {
                          bool isSelected = selectedCategoryIndex == index;
                          var category = categoriesData![index];

                          return GestureDetector(
                            onTap: () {
                              print("Category selected: ${category.name}"); // Debug
                              setState(() {
                                selectedCategoryIndex = index;
                                selectedSubCategoryIndex = 0;
                              });

                              // Load subcategories for selected category
                              String? categoryId = category.id;
                              if (categoryId != null) {
                                print("Loading subcategories for ID: $categoryId"); // Debug
                                subCategoryViewModel.getSubCategories(categoryId);
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
                                  category.name ?? "Unknown Category",
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

                  // Default state - show loading or empty state
                  return Container(
                    color: AppColors.babyBlue,
                    child: Center(
                      child: Text(
                        "Loading categories...",
                        style: AppStyles.W400Blue14,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                },
              ),
            ),

            // Middle - Subcategories List
            Expanded(
              flex: 3,
              child: BlocConsumer<HomeTabViewModel, HomeTabStates>(
                bloc: subCategoryViewModel,
                listener: (context, state) {
                  if (state is SubCategoryErrorState) {
                    print("SubCategory Error: ${state.toString()}");
                  }
                },
                builder: (context, state) {
                  print("SubCategories State: ${state.runtimeType}"); // Debug

                  if (state is SubCategoryLoadingState) {
                    return Container(
                      color: AppColors.whiteColor,
                      child: const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primaryColor,
                        ),
                      ),
                    );
                  }
                  else if (state is SubCategoryErrorState) {
                    return Container(
                      color: AppColors.whiteColor,
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
                    var subCategories = state.subCategoryResponseEntity.data;
                    print("SubCategories loaded: ${subCategories?.length}"); // Debug

                    return Container(
                      color: AppColors.whiteColor,
                      child: ListView.builder(
                        itemCount: subCategories?.length ?? 0,
                        itemBuilder: (context, index) {
                          bool isSelected = selectedSubCategoryIndex == index;
                          var subCategory = subCategories![index];

                          return GestureDetector(
                            onTap: () {
                              print("SubCategory selected: ${subCategory.name}"); // Debug
                              setState(() {
                                selectedSubCategoryIndex = index;
                              });

                              // Load products for selected subcategory
                              String? subCategoryId = subCategory.id;
                              if (subCategoryId != null) {
                                print("Loading products for subcategory: $subCategoryId"); // Debug
                                // viewModel.getProductsBySubCategory(subCategoryId);
                              }
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
                                    ? AppColors.primaryColor.withOpacity(0.1)
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(8),
                                border: isSelected
                                    ? Border.all(color: AppColors.primaryColor, width: 1)
                                    : null,
                              ),
                              child: Center(
                                child: Text(
                                  subCategory.name ?? "Unknown Subcategory",
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