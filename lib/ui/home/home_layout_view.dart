import 'package:e_commerce_app/ui/home/cubit/home_screen_states.dart';
import 'package:e_commerce_app/ui/home/cubit/home_screen_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/constants/app_colors.dart';

class HomeLayoutView extends StatelessWidget {
        HomeLayoutView({super.key});

    HomeScreenViewModel viewModel = HomeScreenViewModel();

  @override
  Widget build(BuildContext context) {

  return BlocBuilder<HomeScreenViewModel , HomeScreenState>(
      bloc: viewModel,
      builder: (BuildContext context, state) {
        return Scaffold(
          backgroundColor: AppColors.whiteColor,
          bottomNavigationBar: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
            child: BottomNavigationBar(
              selectedItemColor: AppColors.whiteColor ,
              unselectedItemColor: AppColors.whiteColor,
              backgroundColor: AppColors.primaryColor,
              type: BottomNavigationBarType.fixed,
              currentIndex: viewModel.selectedIndex,
              onTap: viewModel.onBottomNavBarItemTapped,
              items:  const [

                BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined),
                  activeIcon:Icon(Icons.home) ,
                  label: "Home",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.category_outlined),
                  activeIcon:Icon(Icons.category) ,
                  label: "Categories",
                ),

                BottomNavigationBarItem(
                  icon: Icon(Icons.favorite_border_outlined),
                  activeIcon:Icon(Icons.favorite) ,
                  label: "Favorite",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person_3_outlined),
                  activeIcon:Icon(Icons.person) ,
                  label: "Profile",
                ),
              ],
            ),
          ),
          body: viewModel.tabs[viewModel.selectedIndex],
        );
      },
    );
  }
  }
