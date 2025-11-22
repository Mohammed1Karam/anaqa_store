import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../widget/my_text.dart';
import 'app_colors.dart';

class Helpers {
  static void showSnackBar({required String message, bool error = false}) {
    final context = Get.context;
    if (context != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: MyText(
            text: message,
            fontSize: 15.sp,
            maxLines: 3,
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
          behavior: SnackBarBehavior.floating,
          backgroundColor: error ? AppColors.R_COLOR : AppColors.Blak_COLOR,
        ),
      );
    } else {
      Get.snackbar(
        error ? "خطأ!" : "تنبيه",
        message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: error ? AppColors.R_COLOR : AppColors.Blak_COLOR,
        colorText: Colors.white,
        margin: EdgeInsets.all(10.w),
      );
    }
  }
}
