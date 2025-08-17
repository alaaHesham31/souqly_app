import 'package:e_commerce_app/core/utils/app_assets.dart';
import 'package:e_commerce_app/core/utils/app_colors.dart';
import 'package:e_commerce_app/feature/ui/tabs/categories/categories_view.dart';
import 'package:e_commerce_app/feature/ui/tabs/favourite/favourite_view.dart';
import 'package:e_commerce_app/feature/ui/tabs/home/home_view.dart';
import 'package:e_commerce_app/feature/ui/tabs/profile/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  List<Widget> tabs = [
    HomeView(),
    CategoriesView(),
    FavouriteView(),
    ProfileView()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        child: BottomNavigationBar(
            currentIndex: selectedIndex,
            onTap: (index) {
              setState(() {
                selectedIndex = index;
              });
            },
            items: [
              BottomNavigationBarItem(
                label: '',
                icon: buildHoverOnSelectedIcon(
                    index: 0,
                    unSelectedIconPath: AppAssets.homeIcon,
                    selectedIconPath: AppAssets.selectedHomeIcon),
              ),
              BottomNavigationBarItem(
                label: '',
                icon: buildHoverOnSelectedIcon(
                    index: 1,
                    unSelectedIconPath: AppAssets.categoryIcon,
                    selectedIconPath: AppAssets.selectedCategoryIcon),
              ),
              BottomNavigationBarItem(
                label: '',
                icon: buildHoverOnSelectedIcon(
                    index: 2,
                    unSelectedIconPath: AppAssets.favouriteIcon,
                    selectedIconPath: AppAssets.selectedFavouriteIcon),
              ),
              BottomNavigationBarItem(
                label: '',
                icon: buildHoverOnSelectedIcon(
                    index: 3,
                    unSelectedIconPath: AppAssets.profileIcon,
                    selectedIconPath: AppAssets.selectedProfileIcon),
              ),
            ]),
      ),
    );
  }

  Widget buildHoverOnSelectedIcon(
      {required int index,
      required String unSelectedIconPath,
      required String selectedIconPath}) {
    return index == selectedIndex
        ? Container(
            padding: EdgeInsets.all(8.h),
            decoration: BoxDecoration(
                color: AppColors.whiteColor, shape: BoxShape.circle),
            child: Image(
              image: AssetImage(selectedIconPath),
            ),
          )
        : Image(image: AssetImage(unSelectedIconPath));
  }
}
