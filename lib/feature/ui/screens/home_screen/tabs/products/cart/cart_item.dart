import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/core/utils/app_colors.dart';
import 'package:e_commerce_app/core/utils/app_styles.dart';
import 'package:e_commerce_app/domain/entities/GetCartResponseEntity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartItem extends StatelessWidget {
  bool isInFavTab;

  CartItem({super.key, required this.item, this.isInFavTab = false});

  final GetProductsInCartEntity item;

  @override
  Widget build(BuildContext context) {
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
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(item.product?.title ?? '',
                            style: AppStyles.medium16Primary,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,),
                      ),
                      isInFavTab
                          ? IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.favorite_border_rounded,
                                color: AppColors.primaryColor,
                              ))
                          : IconButton(
                              onPressed: () {},
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
                                    onPressed: () {},
                                  ),
                                  Text(item.count.toString(),
                                      style: AppStyles.medium18White),
                                  IconButton(
                                    icon: Icon(
                                      Icons.add_circle_outline,
                                      color: AppColors.whiteColor,
                                      size: 24.sp,
                                    ),
                                    onPressed: () {},
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
