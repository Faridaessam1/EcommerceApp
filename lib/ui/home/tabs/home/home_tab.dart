import 'package:e_commerce_app/core/constants/app_assets.dart';
import 'package:e_commerce_app/core/constants/app_colors.dart';
import 'package:e_commerce_app/core/constants/app_styles.dart';
import 'package:e_commerce_app/core/widgets/custom_text_form_field.dart';
import 'package:e_commerce_app/ui/home/tabs/home/cubit/home_tab_states.dart';
import 'package:e_commerce_app/ui/home/tabs/home/cubit/home_tab_view_model.dart';
import 'package:e_commerce_app/ui/home/widgets/ads_card_widget.dart';
import 'package:e_commerce_app/ui/home/widgets/categories_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/di.dart';

class HomeTab extends StatefulWidget {
  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  late final HomeTabViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = getIt<HomeTabViewModel>();
    viewModel.getAllCategories();
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
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Search Row
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: CustomTextFormField(
                      hintTextColor: AppColors.grayColor,
                      borderColor: AppColors.primaryColor,
                      hintText: "What do you search for?",
                      filledColor: AppColors.whiteColor,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Image.asset(
                        AppAssets.shoppingIcon,
                        height: height * 0.03,
                        width: width * 0.03,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: height * 0.02),

              // Ads Section
              SizedBox(
                height: height * 0.21,
                child: PageView.builder(
                  itemCount: viewModel.adsImages.length,
                  itemBuilder: (context, index) => AdsCardWidget(
                    imagePath: viewModel.adsImages[index],
                  ),
                ),
              ),

              SizedBox(height: height * 0.02),

              // Categories Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Categories",
                    style: AppStyles.W500White18.copyWith(color: Colors.black),
                  ),
                  GestureDetector(
                    onTap: () {
                      // TODO: Navigate to categories page
                    },
                    child: Text(
                      "View All",
                      style: AppStyles.W300White16.copyWith(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: height * 0.03),

              // Categories Grid
              BlocBuilder<HomeTabViewModel, HomeTabStates>(
                bloc: viewModel,
                builder: (BuildContext context, HomeTabStates state) {
                  if (state is CategoryLoadingState) {
                    return SizedBox(
                      height: height * 0.3,
                      child: const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primaryColor,
                        ),
                      ),
                    );
                  } else if (state is CategoryErrorState) {
                    return SizedBox(
                      height: height * 0.3,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Something Went Wrong!",
                              style: AppStyles.W500White18.copyWith(color: Colors.red),
                            ),
                            SizedBox(height: 10),
                            ElevatedButton(
                              onPressed: () {
                                viewModel.getAllCategories();
                              },
                              child: Text("Retry"),
                            ),
                          ],
                        ),
                      ),
                    );
                  } else if (state is CategorySuccessState) {
                    final categories = state.categoryResponseEntity.categoryData;

                    if (categories == null || categories.isEmpty) {
                      return SizedBox(
                        height: height * 0.3,
                        child: Center(
                          child: Text(
                            "No categories found",
                            style: AppStyles.W300White16.copyWith(color: Colors.grey),
                          ),
                        ),
                      );
                    }

                    // Calculate grid height based on items
                    final itemCount = categories.length;
                    final rows = (itemCount / 4).ceil();
                    final gridHeight = (rows * (height * 0.12)) + ((rows - 1) * (height * 0.04));

                    return SizedBox(
                      height: gridHeight.clamp(height * 0.12, height * 0.5),
                      child: GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          crossAxisSpacing: 15,
                          mainAxisSpacing: height * 0.04,
                          childAspectRatio: 0.8,
                        ),
                        itemCount: categories.length,
                        itemBuilder: (context, index) => CategoriesCardWidget(
                          item: categories[index],
                        ),
                      ),
                    );
                  }
                  return Container();
                },
              ),

              // Add some bottom padding
              SizedBox(height: height * 0.02),
            ],
          ),
        ),
      ),
    );
  }
}