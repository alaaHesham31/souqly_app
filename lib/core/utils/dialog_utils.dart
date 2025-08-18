import 'package:e_commerce_app/core/utils/app_colors.dart';
import 'package:e_commerce_app/core/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DialogUtils {
  // Success dialog (important events)
  static void showSuccessDialog(BuildContext context,
      {String? title, String? message}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        title: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.green),
            const SizedBox(width: 8),
            Text(title ?? "Success", style: AppStyles.bold18Primary),
          ],
        ),
        content: Text(
          message ?? "Operation completed successfully!",
          style: AppStyles.medium16Black,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("OK", style: AppStyles.medium16Primary),
          ),
        ],
      ),
    );
  }

  //  Success snackBar (minor events)
  static void showSuccessSnackBar(BuildContext context, String? message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message ?? "Done!",
          style: AppStyles.medium16White,
        ),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(12.w),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  //  Error dialog
  static void showErrorDialog(BuildContext context,
      {String? title, String? message}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        title: Row(
          children: [
            const Icon(Icons.error_outline, color: Colors.red),
            const SizedBox(width: 8),
            Text(title ?? "Error", style: AppStyles.bold18Red),
          ],
        ),
        content: Text(
          message ?? "Something went wrong!",
          style: AppStyles.medium16Black,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("OK", style: AppStyles.medium16Primary),
          ),
        ],
      ),
    );
  }

  //  Loading dialog
  static void showLoading(BuildContext context, {String? message}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        content: Row(
          children: [
            const CircularProgressIndicator(
              color: AppColors.primaryColor,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message ?? "Loading...",
                style: AppStyles.medium16Primary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  static void hideLoading(BuildContext context) {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
  }
}
