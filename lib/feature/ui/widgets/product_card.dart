import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/core/utils/app_colors.dart';
import 'package:e_commerce_app/core/utils/app_styles.dart';
import 'package:e_commerce_app/domain/entities/ProductsResponseEntity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductCard extends StatelessWidget {
  ProductEntity item;

  ProductCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: AppColors.primaryColor, width: 2.w)),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 128.h,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(16.r),
                    topLeft: Radius.circular(16.r),
                  ),
                  child: CachedNetworkImage(
                    width: double.infinity,
                    // height: 191.h,
                    fit: BoxFit.cover,
                    imageUrl: item.imageCover ?? "",
                    placeholder: (context, url) => CircularProgressIndicator(
                      color: AppColors.primaryColor,
                    ),
                    errorWidget: (context, url, error) => Icon(
                      Icons.error,
                      color: AppColors.redColor,
                    ),
                    imageBuilder: (context, ImageProvider) {
                      return Image.network(
                        item.imageCover ?? "",
                      );
                    },
                  ),
                ),
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
          ),
          SizedBox(
            height: 8.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  item.title ?? "",
                  style: AppStyles.regular14Primary,
                ),
                Text(
                  item.description ?? "",
                  maxLines: 2,
                  style: AppStyles.regular14Primary,
                ),
                SizedBox(
                  height: 8.h,
                ),
                Row(
                  children: [
                    Text(
                      '${item.price.toString()} EGP ',
                      style: AppStyles.regular14Primary,
                    ),
                    SizedBox(
                      height: 16.w,
                    ),
                    Text(
                      '${item.price.toString() * 2} EGP ',
                      style: AppStyles.regular14PrimaryStrikethrough,
                    ),
                  ],
                ),
                SizedBox(
                  height: 8.h,
                ),
                Row(
                  children: [
                    Text(
                      'Review (${item.ratingsAverage}) ',
                      style: AppStyles.regular14Primary,
                    ),
                    SizedBox(
                      height: 4.w,
                    ),
                    Icon(
                      Icons.star,
                      color: AppColors.yellowColor,
                    ),
                    Spacer(),
                    Icon(
                      Icons.add_circle,
                      color: AppColors.primaryColor,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
