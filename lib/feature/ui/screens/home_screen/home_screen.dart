import 'package:e_commerce_app/core/utils/app_assets.dart';
import 'package:e_commerce_app/core/utils/app_colors.dart';
import 'package:e_commerce_app/feature/ui/screens/home_screen/cubit/home_screen_states.dart';
import 'package:e_commerce_app/feature/ui/screens/home_screen/cubit/home_screen_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  HomeScreenViewModel viewModel = HomeScreenViewModel();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeScreenViewModel, HomeScreenStates>(
      bloc: viewModel,
      builder: (context, state) {
        return Scaffold(
          body: viewModel.tabs[viewModel.selectedIndex],
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: BottomNavigationBar(
                currentIndex: viewModel.selectedIndex,
                onTap: (index) {
                  setState(() {
                    viewModel.selectedIndex = index;
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
      },
    );
  }

  Widget buildHoverOnSelectedIcon(
      {required int index,
      required String unSelectedIconPath,
      required String selectedIconPath}) {
    return index == viewModel.selectedIndex
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
