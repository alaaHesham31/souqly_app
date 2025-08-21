
import 'package:e_commerce_app/core/di/di.dart';
import 'package:e_commerce_app/core/utils/app_assets.dart';
import 'package:e_commerce_app/core/utils/app_colors.dart';
import 'package:e_commerce_app/core/utils/app_styles.dart';
import 'package:e_commerce_app/domain/entities/CategoryOrBrandEntity.dart';
import 'package:e_commerce_app/feature/ui/screens/home_screen/tabs/home/cubit/home_tab_states.dart';
import 'package:e_commerce_app/feature/ui/screens/home_screen/tabs/home/cubit/home_tab_view_model.dart';
import 'package:e_commerce_app/feature/ui/widgets/category_brand_item.dart';
import 'package:e_commerce_app/feature/ui/widgets/search_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';

class HomeTab extends StatefulWidget {
  HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  HomeTabViewModel viewModel = getIt<HomeTabViewModel>();

  @override
  void initState() {
    super.initState();
    viewModel = getIt<HomeTabViewModel>();
    viewModel.getAllCategories();
    viewModel.getAllBrands();
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Image(
            image: AssetImage(AppAssets.appLogo),
            color: AppColors.primaryColor,
            width: 200.w,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SearchBarWidget(
                  controller: viewModel.controller,
                  onCartTab: () {},
                ),
                SizedBox(
                  height: 16.h,
                ),
                _buildImageSlideShow(images: viewModel.images),
                SizedBox(
                  height: 24.h,
                ),
                _buildBreakLine(title: 'Categories'),
                BlocBuilder<HomeTabViewModel, HomeTabStates>(
                    buildWhen: (previous, current) =>
                    current is CategoriesLoadingState ||
                        current is CategoriesSuccessState ||
                        current is CategoriesErrorState,
                    bloc: viewModel,
                    builder: (context, state) {
                      if (state is CategoriesLoadingState) {
                      return  Center(child: CircularProgressIndicator(color: AppColors.primaryColor,),);
                      } else if (state is CategoriesErrorState) {
                         return Text(state.error.errorMessage);
                      } else if(state is CategoriesSuccessState){
                        return
                        _buildCategoryBrandSec(list: state.categoryOrBrandEntity.data!);
                      }
                      return SizedBox.shrink();
                    }),
                SizedBox(
                  height: 24.h,
                ),
                _buildBreakLine(title: 'Brands'),
                BlocBuilder<HomeTabViewModel, HomeTabStates>(
                    buildWhen: (previous, current) =>
                    current is BrandsLoadingState ||
                        current is BrandsSuccessState ||
                        current is BrandsErrorState,
                    bloc: viewModel,
                    builder: (context, state) {
                      if (state is BrandsLoadingState) {
                        return  Center(child: CircularProgressIndicator(color: AppColors.primaryColor,),);
                      } else if (state is BrandsErrorState) {
                       return Text(state.error.errorMessage);
                      } else if(state is BrandsSuccessState){
                        return
                          _buildCategoryBrandSec(list: state.categoryOrBrandEntity.data!);
                      }
                      return SizedBox.shrink();
                    }),
                SizedBox(
                  height: 24.h,
                ),
                ],
            ),
          ),
        ),
      ),
    );
  }

  ImageSlideshow _buildImageSlideShow({required List<String> images}) {
    return ImageSlideshow(
        indicatorColor: AppColors.primaryColor,
        indicatorBackgroundColor: AppColors.whiteColor,
        initialPage: 0,
        isLoop: true,
        indicatorRadius: 5,
        indicatorBottomPadding: 8.h,
        indicatorPadding: 8.w,
        autoPlayInterval: 3000,
        height: 190.h,
        children: images.map((url) {
          return Image.asset(url);
        }).toList());
  }

  Widget _buildBreakLine({required String title}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: AppStyles.medium18Primary,
        ),
        TextButton(
          onPressed: () {},
          child: Text(
            'view all',
            style: AppStyles.regular12Primary,
          ),
        )
      ],
    );
  }

  _buildCategoryBrandSec({required  List<CategoryOrBrandDataEntity> list}) {
    return SizedBox(
      height: 250.h,
      width: double.infinity,
      child: GridView.builder(
          itemCount: list.length,
          scrollDirection: Axis.horizontal,
          physics: ScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, mainAxisSpacing: 16.w, crossAxisSpacing: 16.h),
          itemBuilder: (context, index) {
            return CategoryBrandItem(itemEntity: list[index],);
          }),
    );
  }
}
