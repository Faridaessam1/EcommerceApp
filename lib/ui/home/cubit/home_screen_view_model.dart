import 'package:e_commerce_app/ui/home/cubit/home_screen_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../tabs/categories/categories_tab.dart';
import '../tabs/favorite/favorite_tab.dart';
import '../tabs/home/home_tab.dart';
import '../tabs/profile/profile_tab.dart';

class HomeScreenViewModel extends Cubit<HomeScreenState>{
  HomeScreenViewModel():super(HomeScreenInitialState());

  int selectedIndex = 1 ;
  List<Widget> tabs = [
    HomeTab(),
    CategoriesTab(),
    FavoriteTab(),
    ProfileTab(),

  ];

  void onBottomNavBarItemTapped(int index){
    selectedIndex = index;
    emit(HomeChangeSelectedIndexState());
  }

}