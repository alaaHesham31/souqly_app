import 'package:e_commerce_app/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FilterTabsWidget extends StatelessWidget {
  bool isSelected;
  String subCategoryName;
  Color backgroundSelectedColor;
  Color borderUnSelectedColor;

  TextStyle selectedTextStyle;
  TextStyle unSelectedTextStyle;

  FilterTabsWidget({
    super.key,
    required this.isSelected,
    required this.subCategoryName,
    required this.backgroundSelectedColor,
    required this.borderUnSelectedColor,
    required this.selectedTextStyle,
    required this.unSelectedTextStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 12.w,
        vertical: 12.h,
      ),
      margin: EdgeInsets.only(right: 12.w),
      decoration: BoxDecoration(
        color:
            isSelected ? backgroundSelectedColor : AppColors.transparentColor,
        borderRadius: BorderRadius.circular(46.r),
        border: Border.all(color: borderUnSelectedColor, width: 1.w),
      ),
      child: Text(
        subCategoryName,
        style: isSelected ? selectedTextStyle : unSelectedTextStyle,
      ),
    );
  }
}
