import 'package:e_commerce_app/core/utils/app_colors.dart';
import 'package:e_commerce_app/core/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatelessWidget {
  TextEditingController controller;
  String hintText;
  final String? Function(String?)? validator;
  bool? obscureText;
  Image? suffixIcon;
  Widget? prefixIcon;
  double? borderRadius;
  Color? borderColor;
  TextInputType? keyboardType;

  CustomTextField(
      {super.key,
      required this.controller,
      required this.hintText,
      this.validator,
      this.obscureText,
      this.suffixIcon,
      this.prefixIcon,
      this.borderRadius,
      this.borderColor,
      this.keyboardType});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      cursorColor: AppColors.primaryColor,
      obscureText: obscureText ?? false,
      obscuringCharacter: '*',
      style: AppStyles.medium18Primary,
      keyboardType: keyboardType ?? TextInputType.text,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.whiteColor,
        hintText: hintText,
        hintStyle: AppStyles.light18Grey,
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        contentPadding: EdgeInsets.all(20.h),
        border: OutlineInputBorder(
          borderSide:
              BorderSide(color: borderColor ?? AppColors.whiteColor, width: 1),
          borderRadius: BorderRadius.circular(borderRadius ?? 16),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: borderColor ?? AppColors.whiteColor, width: 1),
          borderRadius: BorderRadius.circular(borderRadius ?? 16),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: borderColor ?? AppColors.whiteColor, width: 1),
          borderRadius: BorderRadius.circular(borderRadius ?? 16),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.redColor, width: 1),
          borderRadius: BorderRadius.circular(borderRadius ?? 16),
        ),
      ),
    );
  }
}
