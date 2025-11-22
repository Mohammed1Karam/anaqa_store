import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tullana/utils/app_colors.dart';

class TangoTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool obscureText;
  final Widget? suffixText;
  final Widget? prefixW;
  final TextInputType? textInputType;
  final String? errorText;
  final String? Function(String?)? validator; // ✅ أضفنا هذا

  const TangoTextField({
    super.key,
    required this.label,
    required this.controller,
    this.obscureText = false,
    this.suffixText,
    this.prefixW,
    this.textInputType,
    this.errorText,
    this.validator, // ✅ أضفنا هذا

  });

  @override
  Widget build(BuildContext context) {
    final defaultBorderColor = AppColors.S_COLOR;
    final focusedBorderColor = AppColors.D_COLOR;
    final errorColor = Colors.red.shade700;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0.w),
      child: SizedBox(
        // height: 45.h,
        child: TextFormField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: textInputType,
          validator: validator, // ✅ استخدم validator هنا

          cursorColor: (errorText != null) ? errorColor : focusedBorderColor,
          style: TextStyle(
            color: (errorText != null) ? errorColor : AppColors.Blak_COLOR,
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
          ),
          decoration: InputDecoration(
            hintText: label,
            errorText: errorText,
            prefixIcon: prefixW,
            errorStyle: TextStyle(
              color: errorColor,
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
            ),
            hintStyle: TextStyle(
              color: AppColors.S_COLOR,
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
            suffixIcon: suffixText,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.r),
              borderSide: BorderSide(
                color: defaultBorderColor,
                width: 1.w,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.r),
              borderSide: BorderSide(
                color: focusedBorderColor,
                width: 1.5.w,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.r),
              borderSide: BorderSide(
                color: errorColor,
                width: 1.5.w,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.r),
              borderSide: BorderSide(
                color: errorColor,
                width: 2.w,
              ),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
          ),
        ),
      ),
    );
  }
}