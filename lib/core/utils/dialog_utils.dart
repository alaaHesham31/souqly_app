import 'package:e_commerce_app/core/utils/app_colors.dart';
import 'package:e_commerce_app/core/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:status_alert/status_alert.dart';

class DialogUtils {
  // success alert
  static void showSuccess(
      BuildContext context, String? title, String? subTitle) {
    StatusAlert.show(context,
        duration: const Duration(seconds: 2),
        title: title ?? 'Done',
        subtitle: subTitle ?? '',
        configuration: IconConfiguration(icon: Icons.done),
        maxWidth: 200.w,
        backgroundColor: AppColors.white54Color);
  }

  // error dialog
  static void showError(BuildContext context, String? title, String? subTitle) {
    StatusAlert.show(context,
        duration: const Duration(seconds: 2),
        title: title ?? 'Error',
        subtitle: subTitle ?? 'Something went wrong!',
        configuration: IconConfiguration(
            icon: Icons.error_outline, color: AppColors.redColor),
        maxWidth: 200.w,
        backgroundColor: AppColors.white54Color);
  }

  // show loading
  static showLoading(BuildContext context, String? message) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Row(
              children: [
                const CircularProgressIndicator(
                  color: AppColors.primaryColor,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    message ?? 'Loading....',
                    style: AppStyles.medium18Primary,
                  ),
                ),
              ],
            ),
          );
        });
  }
}
