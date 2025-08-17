import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastMessage {
  static Future<bool?> showToastMsg(
      String message, Color textColor, Color backgroundColor) {
    return Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      backgroundColor: backgroundColor,
      timeInSecForIosWeb: 1,
      textColor: textColor,
      gravity: ToastGravity.BOTTOM,
      fontSize: 20.sp,
    );
  }
}
