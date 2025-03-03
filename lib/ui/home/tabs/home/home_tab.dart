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

class HomeTab extends StatelessWidget {
  HomeTabViewModel viewModel = getIt<HomeTabViewModel>();

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
                      child: Image.asset(
                        AppAssets.shoppingIcon,
                        height: height * 0.03,
                        width: width * 0.03,
                      ))
                ],
              ),
              SizedBox(
                height: height * 0.02,
              ),
              SizedBox(
                height: height * 0.21,
                child: PageView.builder(
                  itemCount: viewModel.adsImages.length,
                  itemBuilder: (context, index) => AdsCardWidget(
                    imagePath: viewModel.adsImages[index],
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Row(
                children: [
                  Text(
                    "Categories",
                    style: AppStyles.W500White18.copyWith(color: Colors.black),
                  ),
                  const Spacer(),
                  Text(
                    "View All",
                    style: AppStyles.W300White16.copyWith(
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: height * 0.03,
              ),
              BlocBuilder<HomeTabViewModel, HomeTabStates>(
                bloc: viewModel..getAllCategories(),
                builder: (BuildContext context, HomeTabStates state) {
                  if (state is CategoryLoadingState) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primaryColor,
                      ),
                    );
                  } else if (state is CategoryErrorState) {
                    return Center(
                      child: Text(
                        "SomeThing Went Wrong!",
                        style: AppStyles.W500White18.copyWith(color: Colors.red),
                      ),
                    );
                  } else if (state is CategorySuccessState) {
                    return SizedBox(
                      height: height * 0.45,
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          crossAxisSpacing: 15,
                          mainAxisSpacing: height * 0.04,
                        ),
                        itemCount:state.categoryResponseEntity.categoryData!.length,
                        itemBuilder: (context, index) => CategoriesCardWidget(
                          item: state.categoryResponseEntity.categoryData![index],
                        ),
                      ),
                    );
                  }
                  return Container();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
