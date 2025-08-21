import 'package:bloc/bloc.dart';
import 'package:e_commerce_app/feature/ui/screens/home_screen/cubit/home_screen_states.dart';
import 'package:e_commerce_app/feature/ui/screens/home_screen/tabs/categories/categories_view.dart';
import 'package:e_commerce_app/feature/ui/screens/home_screen/tabs/favourite/favourite_view.dart';
import 'package:e_commerce_app/feature/ui/screens/home_screen/tabs/home/home_tab.dart';
import 'package:e_commerce_app/feature/ui/screens/home_screen/tabs/profile/profile_view.dart';
import 'package:flutter/material.dart';

class HomeScreenViewModel extends Cubit<HomeScreenStates>{
  HomeScreenViewModel(): super(HomeScreenInitState());
  int selectedIndex = 0;
  List<Widget> tabs = [
    HomeTab(),
    CategoriesView(),
    FavouriteView(),
    ProfileView()
  ];


  void bottomNavOnTap (int index){
    selectedIndex = index;
emit(ChangeSelectedIndex());
  }
}