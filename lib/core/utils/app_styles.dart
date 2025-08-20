import 'package:e_commerce_app/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AppStyles{

  // texts with white
  static TextStyle semiBold24White =  GoogleFonts.poppins(
    fontSize: 24.sp, fontWeight: FontWeight.w600, color: AppColors.whiteColor
  );
  static TextStyle light16White =  GoogleFonts.poppins(
      fontSize: 16.sp, fontWeight: FontWeight.w300, color: AppColors.whiteColor
  );
  static TextStyle medium18White =  GoogleFonts.poppins(
      fontSize: 18.sp, fontWeight: FontWeight.w500, color: AppColors.whiteColor
  );
  static TextStyle medium16White =  GoogleFonts.poppins(
      fontSize: 16.sp, fontWeight: FontWeight.w500, color: AppColors.whiteColor
  );
  static TextStyle regular18White =  GoogleFonts.poppins(
      fontSize: 18.sp, fontWeight: FontWeight.w400, color: AppColors.whiteColor
  );

  // texts with grey color
  static TextStyle light18Grey =  GoogleFonts.poppins(
      fontSize: 18.sp, fontWeight: FontWeight.w400, color: AppColors.greyColor
  );

  // texts with primary color

  static TextStyle semiBold20Primary =  GoogleFonts.poppins(
      fontSize: 20.sp, fontWeight: FontWeight.w600, color: AppColors.primaryColor
  );
  static TextStyle medium18Primary =  GoogleFonts.poppins(
      fontSize: 18.sp, fontWeight: FontWeight.w500, color: AppColors.primaryColor
  );
  static TextStyle medium16Primary =  GoogleFonts.poppins(
      fontSize: 16.sp, fontWeight: FontWeight.w500, color: AppColors.primaryColor
  );
  static TextStyle bold18Primary =  GoogleFonts.poppins(
      fontSize: 18.sp, fontWeight: FontWeight.w700, color: AppColors.primaryColor
  );
  static TextStyle regular12Primary =  GoogleFonts.poppins(
      fontSize: 12.sp, fontWeight: FontWeight.w400, color: AppColors.primaryColor
  );
  // texts with black color

  static TextStyle medium18Black =  GoogleFonts.poppins(
      fontSize: 18.sp, fontWeight: FontWeight.w400, color: AppColors.darkNavyColor
  );
  static TextStyle medium16Black =  GoogleFonts.poppins(
      fontSize: 16.sp, fontWeight: FontWeight.w500, color: AppColors.primaryColor
  );


  // texts with red color

  static TextStyle bold18Red =  GoogleFonts.poppins(
      fontSize: 18.sp, fontWeight: FontWeight.w700, color: AppColors.primaryColor
  );



}

