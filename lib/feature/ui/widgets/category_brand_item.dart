import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/core/utils/app_colors.dart';
import 'package:e_commerce_app/core/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryBrandItem extends StatelessWidget {
  const CategoryBrandItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 8,
          child: CachedNetworkImage(
            width: double.infinity,
            height: 10.h,
            fit: BoxFit.cover,
            imageUrl: "https://cdn-icons-png.flaticon.com/512/6858/6858504.png",
            placeholder: (context, url) => CircularProgressIndicator( color: AppColors.primaryColor,),
            errorWidget: (context, url, error) => Icon(
              Icons.error,
              color: AppColors.redColor,
            ),
            imageBuilder: (context, ImageProvider) {
              return CircleAvatar(
                backgroundImage: ImageProvider,
                radius: 50.r,
              );
            },
          ),
        ),
        SizedBox(height: 8.h,),
        Expanded(
          child: Text(
            'Women’s fashion',
            style: AppStyles.regular12Primary,
            softWrap: true,
            textWidthBasis: TextWidthBasis.longestLine,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
