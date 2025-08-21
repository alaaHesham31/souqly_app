import 'package:e_commerce_app/core/utils/app_colors.dart';
import 'package:e_commerce_app/core/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomElevatedButton extends StatelessWidget {
  String text;
  VoidCallback? onPressed;
  Color? color;
  TextStyle? textStyle;
  Widget? prefixImage;
  Image? suffixImage;
  double? borderRadius;

  CustomElevatedButton(
      {super.key,
      required this.text,
      required this.onPressed,
      this.color,
      this.textStyle,
      this.prefixImage,
        this.suffixImage,
      this.borderRadius});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            backgroundColor: color ?? AppColors.primaryColor,
            padding: EdgeInsets.symmetric( vertical: 16.h, horizontal: 16.w),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? 20.0))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (prefixImage != null) prefixImage!,
            Text(
              text,
              style: textStyle ?? AppStyles.medium18White,

            ),
            if (suffixImage != null) suffixImage!,

          ],
        ));
  }
}
