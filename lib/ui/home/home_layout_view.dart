import 'package:e_commerce_app/ui/home/categories_tab.dart';
import 'package:e_commerce_app/ui/home/home_tab.dart';
import 'package:e_commerce_app/ui/home/profile_tab.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import 'favorite_tab.dart';

class HomeLayoutView extends StatefulWidget {
  const HomeLayoutView({super.key});

  @override
  State<HomeLayoutView> createState() => _LayoutViewState();
}

class _LayoutViewState extends State<HomeLayoutView> {
  int selectedIndex = 0 ;
  List<Widget> tabs = [
    HomeTab(),
    CategoriesTab(),
    FavoriteTab(),
    ProfileTab(),

  ];
  @override
  Widget build(BuildContext context) {

    return Scaffold(

        backgroundColor: AppColors.whiteColor,

      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: AppColors.whiteColor ,
        unselectedItemColor: AppColors.whiteColor,
        backgroundColor: AppColors.primaryColor,
        type: BottomNavigationBarType.fixed,
        currentIndex: selectedIndex,
        onTap: onBottomNavBarItemTapped,
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
      body: tabs[selectedIndex],

    );
  }

  void onBottomNavBarItemTapped(int index){
    selectedIndex = index;
    setState(() {

    });
  }
}
