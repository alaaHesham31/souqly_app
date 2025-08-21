import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/core/utils/app_colors.dart';
import 'package:e_commerce_app/core/utils/app_styles.dart';
import 'package:e_commerce_app/feature/ui/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:readmore/readmore.dart';

class ProductDetailsScreen extends StatelessWidget {
  ProductDetailsScreen({super.key});

  List<String> images = [
    "https://media.wired.com/photos/63728604691ed08cc4b98976/3:2/w_2560%2Cc_limit/Nike-Swoosh-News-Gear.jpg",
    "https://media.wired.com/photos/63728604691ed08cc4b98976/3:2/w_2560%2Cc_limit/Nike-Swoosh-News-Gear.jpg",
    "https://media.wired.com/photos/63728604691ed08cc4b98976/3:2/w_2560%2Cc_limit/Nike-Swoosh-News-Gear.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Product Details',
          style: AppStyles.medium20Black,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.search_rounded,
              color: AppColors.primaryColor,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.shopping_cart_outlined,
              color: AppColors.primaryColor,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.all(18.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Stack(
                children: [
                  SizedBox(
                      height: 400.h, child: _buildImageSlideShow(images: images)),
                  Positioned(
                    top: 8.h,
                    right: 8.w,
                    child: Icon(
                      Icons.favorite_border_rounded,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 24.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Nike Air Jordon',
                    style: AppStyles.medium18Black,
                  ),
                  Text(
                    'EGP 3,500',
                    style: AppStyles.medium18Black,
                  ),
                ],
              ),
              SizedBox(
                height: 16.h,
              ),
              Row(
                children: [
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: AppColors.greyColor, width: 1.w),
                        borderRadius: BorderRadius.circular(20.r)),
                    child: Text(
                      '3,230 Sold',
                      style: AppStyles.medium18Black,
                    ),
                  ),
                  SizedBox(
                    width: 16.w,
                  ),
                  Icon(
                    Icons.star,
                    color: AppColors.yellowColor,
                  ),
                  SizedBox(
                    height: 4.w,
                  ),
                  Text(
                    '4.8 (7,500) ',
                    style: AppStyles.regular14Primary,
                  ),
                  Spacer(),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.add_circle,
                            color: AppColors.whiteColor,
                          ),
                        ),
                        AutoSizeText(
                          '1',
                          style: AppStyles.regular18White,
                          minFontSize: 18,
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.remove_circle,
                            color: AppColors.whiteColor,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 16.h,
              ),
              Text(
                'Description',
                style: AppStyles.medium18Black,
              ),
              SizedBox(
                height: 8.h,
              ),
              ReadMoreText(
                'Flutter is Google’s mobile UI open source framework to build high-quality native (super fast) interfaces for iOS and Android apps with the unified codebase.',
                trimLength: 2,
                trimMode: TrimMode.Line,
                colorClickableText: AppColors.greyColor,
                trimCollapsedText: 'Show more',
                trimExpandedText: 'Show less',
                moreStyle: AppStyles.bold18Primary,
              ),
              SizedBox(
                height: 16.h,
              ),
              Row(
                children: <Widget>[
                  Column(
                    children: [
                      Text(
                        'Total price',
                        style: AppStyles.medium16Grey,
                      ),
                      SizedBox(
                        height: 12.h,
                      ),
                      Text(
                        'EGP 3,500',
                        style: AppStyles.medium18Black,
                      ),

                    ],
                  ),
                  Spacer(),
                  Expanded(
                    child: CustomElevatedButton(
                        text: 'Add to cart',
                        textStyle: AppStyles.medium18White,
                        prefixImage: Icon(
                          Icons.add_shopping_cart,
                          color: AppColors.whiteColor,
                        ),
                        onPressed: () {}),
                  ),
                ],
              ),
            ],
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
      indicatorRadius: 5,
      indicatorBottomPadding: 8.h,
      indicatorPadding: 8.w,
      autoPlayInterval: 3000,
      height: 190.h,
      children: images.map((url) {
        return CachedNetworkImage(
          imageUrl: url,
          fit: BoxFit.cover,
          width: double.infinity,
          placeholder: (context, url) => Center(
            child: CircularProgressIndicator(color: AppColors.primaryColor),
          ),
          errorWidget: (context, url, error) => Icon(
            Icons.error,
            color: AppColors.redColor,
          ),
        );
      }).toList(),
    );
  }
}
