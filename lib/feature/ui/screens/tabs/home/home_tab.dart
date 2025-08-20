import 'package:e_commerce_app/core/utils/app_assets.dart';
import 'package:e_commerce_app/core/utils/app_colors.dart';
import 'package:e_commerce_app/core/utils/app_styles.dart';
import 'package:e_commerce_app/feature/ui/widgets/category_brand_item.dart';
import 'package:e_commerce_app/feature/ui/widgets/search_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';

class HomeTab extends StatelessWidget {
  HomeTab({super.key});

  TextEditingController controller = TextEditingController();

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
                  controller: controller,
                  onCartTab: () {},
                ),
                SizedBox(
                  height: 16.h,
                ),
                _buildImageSlideShow(images: [
                  AppAssets.announcement1,
                  AppAssets.announcement2,
                  AppAssets.announcement3,
                ]),
                SizedBox(
                  height: 24.h,
                ),
                _buildBreakLine(title: 'Categories'),
                _buildCategoryBrandSec(CategoryBrandItem()),
                SizedBox(
                  height: 24.h,
                ),
                _buildBreakLine(title: 'Categories'),
                _buildCategoryBrandSec(CategoryBrandItem()),
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

  Widget _buildBreakLine({required String title}){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: AppStyles.medium18Primary,),
        TextButton(onPressed: (){}, child:    Text('view all', style: AppStyles.regular12Primary,),
        )

      ],
    );
  }

  _buildCategoryBrandSec(Widget categoryBrand){
    return SizedBox(
      height: 250.h,
      width: double.infinity,
      child: GridView.builder(
        itemCount: 20,
        scrollDirection: Axis.horizontal,
          physics: ScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, mainAxisSpacing:  16.w, crossAxisSpacing: 16.h),
          itemBuilder: (context, index){
          return categoryBrand;
          }),
    );
  }
}
