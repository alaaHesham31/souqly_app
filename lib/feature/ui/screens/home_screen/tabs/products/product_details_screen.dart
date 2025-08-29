import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/core/utils/app_colors.dart';
import 'package:e_commerce_app/core/utils/app_routes.dart';
import 'package:e_commerce_app/core/utils/app_styles.dart';
import 'package:e_commerce_app/domain/entities/ProductsResponseEntity.dart';
import 'package:e_commerce_app/feature/ui/screens/home_screen/tabs/products/cart/cubit/get_cart_items_view_model.dart';
import 'package:e_commerce_app/feature/ui/screens/home_screen/tabs/products/cubit/products_tab_states.dart';
import 'package:e_commerce_app/feature/ui/screens/home_screen/tabs/products/cubit/products_tab_view_model.dart';
import 'package:e_commerce_app/feature/ui/widgets/cart_icon_widgte.dart';
import 'package:e_commerce_app/feature/ui/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:readmore/readmore.dart';
import 'package:badges/badges.dart' as badges;


class ProductDetailsScreen extends StatelessWidget {
  ProductEntity product;

  ProductDetailsScreen({required this.product});


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
          Padding(
            padding: EdgeInsets.only(right: 12.w),
            child: const CartIconWithBadge(),
          ),        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(18.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Stack(
                children: [
                  SizedBox(
                      height: 400.h,
                      child:
                          _buildImageSlideShow(images: product.images ?? [])),
                  Positioned(
                    top: 8.h,
                    right: 8.w,
                    child: IconButton(
                      onPressed: () {
                        GetCartItemsViewModel.get(context)
                            .addToWishList(product.id ?? '');
                      },
                      icon:
                          BlocBuilder<GetCartItemsViewModel, ProductsTabStates>(
                        builder: (context, state) {
                          final viewModel = GetCartItemsViewModel.get(context);

                          // check if current product is in wishlist
                          final isInWishList =
                              viewModel.wishListIds.contains(product.id);

                          return Icon(
                            isInWishList
                                ? Icons.favorite_rounded
                                : Icons.favorite_border_rounded,
                            color: AppColors.primaryColor,
                          );
                        },
                      ),
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
                  Expanded(
                    child: AutoSizeText(
                      product.title ?? "",
                      style: AppStyles.semiBold20Primary,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    " EGP ${product.price.toString()}",
                    style: AppStyles.semiBold20Primary,
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
                      '${product.quantity} Sold',
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
                    '${product.ratingsAverage} (${product.ratingsQuantity}) ',
                    style: AppStyles.regular14Primary,
                  ),

                ],
              ),
              SizedBox(
                height: 16.h,
              ),
              Text(
                'Description',
                style: AppStyles.semiBold20Primary,
              ),
              SizedBox(
                height: 8.h,
              ),
              ReadMoreText(
                product.description ?? "",
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
                    child:
                        BlocListener<ProductsTabViewModel, ProductsTabStates>(
                      listenWhen: (prev, curr) =>
                          curr is AddToCartSuccessState ||
                          curr is AddToCartErrorState,
                      listener: (context, state) {
                        if (state is AddToCartSuccessState) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  state.addToCartResponseEntity.message ??
                                      "Added to cart"),
                              backgroundColor: Colors.green,
                            ),
                          );
                        } else if (state is AddToCartErrorState) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(state.error.errorMessage),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      },
                      child: CustomElevatedButton(
                          text: 'Add to cart',
                          textStyle: AppStyles.medium18White,
                          prefixImage: Icon(
                            Icons.add_shopping_cart,
                            color: AppColors.whiteColor,
                          ),
                          onPressed: () {
                            context
                                .read<ProductsTabViewModel>()
                                .addProductsToCart(productId: product.id ?? '');
                          }),
                    ),
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
      isLoop: false,
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
