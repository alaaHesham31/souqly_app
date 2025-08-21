import 'package:e_commerce_app/core/utils/app_colors.dart';
import 'package:e_commerce_app/feature/ui/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchBarWidget extends StatelessWidget {
  SearchBarWidget(
      {super.key, required this.controller, required this.onCartTab});

  TextEditingController controller;
  VoidCallback onCartTab;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomTextField(
            controller: controller,
            hintText: 'what do you search for?',
            borderRadius: 20,
            borderColor: AppColors.primaryColor,
            prefixIcon: Icon(Icons.search_rounded, color: AppColors.primaryColor,size: 30.h,)
          ),
        ),
        SizedBox(
          width: 8.w,
        ),
        InkWell(
            onTap: () => onCartTab,
            child: Icon(
              Icons.shopping_cart_outlined,
              size: 30,
              color: AppColors.primaryColor,
            )
            // Image(
            //   image: AssetImage(AppAssets.cartIcon), width: 28.w,
            // ),
            ),
      ],
    );
  }
}
