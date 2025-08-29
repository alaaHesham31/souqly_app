import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/core/di/di.dart';
import 'package:e_commerce_app/core/utils/app_assets.dart';
import 'package:e_commerce_app/core/utils/app_colors.dart';
import 'package:e_commerce_app/core/utils/app_styles.dart';
import 'package:e_commerce_app/domain/entities/ProductsResponseEntity.dart';
import 'package:e_commerce_app/feature/ui/screens/home_screen/tabs/products/cubit/products_tab_states.dart';
import 'package:e_commerce_app/feature/ui/screens/home_screen/tabs/products/cubit/products_tab_view_model.dart';
import 'package:e_commerce_app/feature/ui/screens/home_screen/tabs/wish_list/cubit/wish_list_states.dart';
import 'package:e_commerce_app/feature/ui/screens/home_screen/tabs/wish_list/cubit/wish_list_view_model.dart';
import 'package:e_commerce_app/feature/ui/widgets/search_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WishListTab extends StatefulWidget {
  WishListTab({super.key});

  @override
  State<WishListTab> createState() => _WishListTabState();
}

class _WishListTabState extends State<WishListTab> {
  TextEditingController controller = TextEditingController();

  WishListViewModel viewModel = getIt<WishListViewModel>();

  @override
  void initState() {
    super.initState();
    viewModel.getWishList();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: viewModel,
      child: Scaffold(
        appBar: AppBar(
          title: Image(
            image: AssetImage(AppAssets.appLogo),
            color: AppColors.primaryColor,
            width: 200.w,
          ),
        ),
        body: MultiBlocListener(
          listeners: [
            BlocListener<ProductsTabViewModel, ProductsTabStates>(
              listenWhen: (prev, curr) =>
                  curr is AddToCartSuccessState || curr is AddToCartErrorState,
              listener: (context, state) {
                if (state is AddToCartSuccessState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.addToCartResponseEntity.message ??
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
            ),
            BlocListener<WishListViewModel, WishListStates>(
                listenWhen: (prev, curr) => curr is RemoveWishListSuccessState,
                listener: (context, state) {
                  if (state is RemoveWishListSuccessState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content:
                            Text(state.removeFromWishListEntity.message ?? ''),
                        backgroundColor: Colors.green,
                      ),
                    );
                  }
                })
          ],
          child: BlocBuilder<WishListViewModel, WishListStates>(
            builder: (context, state) {
              if (viewModel.wishList.isNotEmpty) {
                return Padding(
                  padding: EdgeInsets.all(12.sp),
                  child: Column(
                    children: [
                      SearchBarWidget(),
                      SizedBox(
                        height: 24.h,
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: viewModel.wishList.length,
                          itemBuilder: (context, index) {
                            final product = viewModel.wishList[index];
                            return favItem(item: product, context: context);
                          },
                        ),
                      ),
                    ],
                  ),
                );
              } else if (state is WishListLoadingState) {
                return Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primaryColor,
                  ),
                );
              }
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.asset(AppAssets.emptyWishList, height: 200.h, color: AppColors.primaryColor,),
                  SizedBox(height: 32.h,),
                  Text('your wish list is empty', style: AppStyles.medium20Black, textAlign: TextAlign.center, ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget favItem(
      {required ProductEntity item,
      // required int index,
      required BuildContext context}) {
    return Container(
      height: 120.h,
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.primaryColor, width: 2),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image
          Container(
            height: 120.h,
            width: 120.w,
            decoration: BoxDecoration(
              border: Border(
                right: BorderSide(color: AppColors.primaryColor, width: 2),
              ),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(16.r),
                bottomRight: Radius.circular(16.r),
              ),
            ),
            // clipBehavior: Clip.antiAlias,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.r),
              child: CachedNetworkImage(
                imageUrl: item.imageCover ?? '',
                fit: BoxFit.contain,
                placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) =>
                    const Icon(Icons.broken_image, size: 40),
              ),
            ),
          ),
          SizedBox(width: 12.w),

          // Details
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(4.sp),
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        item.title ?? '',
                        style: AppStyles.medium16Primary,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        context
                            .read<WishListViewModel>()
                            .removeFromWishList(item.id ?? '');
                      },
                      icon: Icon(
                        Icons.favorite_rounded,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("EGP ${item.price}", style: AppStyles.medium16Primary),
                    Container(
                      height: 50.h,
                      decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(20.r)),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: 24.w, vertical: 12.h),
                        ),
                        onPressed: () {
                          context
                              .read<ProductsTabViewModel>()
                              .addProductsToCart(productId: item.id ?? '');
                        },
                        child: Text(
                          "Add to Cart",
                          style: AppStyles.medium18White,
                        ),
                      ),
                    ),
                  ],
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
