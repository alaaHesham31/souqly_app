import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/core/di/di.dart';
import 'package:e_commerce_app/core/utils/app_colors.dart';
import 'package:e_commerce_app/core/utils/app_styles.dart';
import 'package:e_commerce_app/domain/entities/GetCartResponseEntity.dart';
import 'package:e_commerce_app/feature/ui/screens/home_screen/tabs/products/cart/cubit/get_cart_items_view_model.dart';
import 'package:e_commerce_app/feature/ui/screens/home_screen/tabs/products/cubit/products_tab_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartItem extends StatelessWidget {
  bool isInFavTab;
  final VoidCallback onDelete;
  final GetProductsInCartEntity item;

  CartItem(
      {super.key,
      required this.item,
      required this.onDelete,
      this.isInFavTab = false});

  GetCartItemsViewModel viewModel = getIt<GetCartItemsViewModel>();

  @override
  Widget build(BuildContext context) {
    final initialCount = item.count?.toInt() ?? 0;

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
                imageUrl: item.product?.imageCover ?? '',
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
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          item.product?.title ?? '',
                          style: AppStyles.medium16Primary,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      isInFavTab
                          ? IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.favorite_border_rounded,
                                color: AppColors.primaryColor,
                              ))
                          : IconButton(
                              onPressed: onDelete,
                              icon: Icon(
                                Icons.delete_rounded,
                                color: AppColors.primaryColor,
                              ))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("EGP ${item.price}",
                          style: AppStyles.medium16Primary),
                      Container(
                        height: 50.h,
                        decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(20.r)),
                        child: isInFavTab
                            ? ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primaryColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.r),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 24.w, vertical: 12.h),
                                ),
                                onPressed: () {},
                                child: Text(
                                  "Add to Cart",
                                  style: AppStyles.medium18White,
                                ),
                              )
                            : Row(
                                children: [
                                  IconButton(
                                    icon: Icon(
                                      Icons.remove_circle_outline,
                                      color: AppColors.whiteColor,
                                      size: 24.sp,
                                    ),
                                    onPressed: () {
                                      // compute new count (prevent negative)
                                      final newCount =
                                          (item.count!.toInt()) - 1;
                                      if (newCount >= 1) {
                                        context
                                            .read<GetCartItemsViewModel>()
                                            .updateCount(newCount,
                                                item.product?.id ?? '');
                                      }
                                    },
                                  ),
                                  BlocBuilder<GetCartItemsViewModel,
                                      ProductsTabStates>(
                                    builder: (context, state) {
                                      int displayCount = initialCount;

                                      if (state is GetCartSuccessState) {
                                        final products = state
                                            .getCartResponseEntity
                                            .data
                                            ?.products;

                                        if (products != null &&
                                            products.isNotEmpty) {
                                          final updated = products.firstWhere(
                                            (p) =>
                                                p.product?.id ==
                                                item.product?.id,
                                            orElse: () => item,
                                          );
                                          displayCount =
                                              updated.count?.toInt() ??
                                                  displayCount;
                                        }
                                      }

                                      return Text(
                                        displayCount.toString(),
                                        style: AppStyles.medium18White,
                                      );
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.add_circle_outline,
                                      color: AppColors.whiteColor,
                                      size: 24.sp,
                                    ),
                                    onPressed: () {
                                      final newCount =
                                          (item.count?.toInt() ?? 0) + 1;
                                      context
                                          .read<GetCartItemsViewModel>()
                                          .updateCount(
                                              newCount, item.product?.id ?? '');
                                    },
                                  ),
                                ],
                              ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
