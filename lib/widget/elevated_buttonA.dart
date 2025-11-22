import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tullana/widget/my_text.dart'; // افتراض أن هذا ملف موجود

// يستخدم هذا الزر زوايا دائرية 25.r
class ElevatedButtonA extends StatelessWidget {
  // التصحيح 1: يجب أن يكون onPressed قابلاً للقيمة الفارغة (VoidCallback?)
  final VoidCallback? onPressed;
  final String text;
  final Color color;
  final Color textColors;
  final Color sideColors;
  final double fontSize;
  // التصحيح 2: تغيير النوع إلى non-nullable مع قيمة افتراضية
  final bool isLoading;
  final Widget? icon;

  const ElevatedButtonA({
    super.key,
    required this.onPressed,
    required this.text,
    required this.color,
    this.textColors = Colors.white,
    this.sideColors = Colors.black,
    this.fontSize = 16,
    this.isLoading = false,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    // إذا كان isLoading صحيحًا، فسيتم تعيين onPressed على null لتعطيل الزر
    final VoidCallback? actualOnPressed = isLoading ? null : onPressed;
    final Color effectiveSideColor = actualOnPressed == null ? sideColors.withOpacity(0.5) : sideColors;

    return ElevatedButton.icon (
      // نمرر actualOnPressed، والذي قد يكون null
      icon: isLoading ?
      SizedBox(
        width: 20.r,
        height: 20.r,
        child: const CircularProgressIndicator(
          color: Colors.white,
          strokeWidth: 2.5,
        ),
      )
          : (icon ?? const SizedBox.shrink()),

      onPressed: actualOnPressed,
      style: ElevatedButton.styleFrom(
        elevation: 0,
        // تقليل الشفافية إذا كان الزر معطلاً/يحمل
        backgroundColor: actualOnPressed == null ? color.withOpacity(0.7) : color,
        minimumSize: Size(double.infinity, 51.h),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.r),
            side: BorderSide(
              color: effectiveSideColor,
            )
        ),
      ),
      label: Text(
        // عرض نص التحميل إذا كان الزر يحمل
        isLoading ? 'LOADING...' : text,
        style: TextStyle(
          fontSize: fontSize.sp,
          // تقليل شفافية النص إذا كان الزر معطلاً
          color: actualOnPressed == null ? textColors.withOpacity(0.5) : textColors,
          fontWeight: FontWeight.bold,
          fontFamily:'Outfit',
        ),
      ),
    );
  }
}

// يستخدم هذا الزر زوايا دائرية 15.r
class ElevatedButtonAA extends StatelessWidget {
  // التصحيح 1: يجب أن يكون onPressed قابلاً للقيمة الفارغة (VoidCallback?)
  final VoidCallback? onPressed;
  final String text;
  final Color color;
  final Color textColors;
  final Color sideColors;
  final double fontSize;
  // التصحيح 2: تغيير النوع إلى non-nullable مع قيمة افتراضية
  final bool isLoading;
  final Widget? icon;

  const ElevatedButtonAA({
    super.key,
    required this.onPressed,
    required this.text,
    required this.color,
    this.textColors = Colors.white,
    this.sideColors = Colors.black,
    this.fontSize = 16,
    this.isLoading = false,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final VoidCallback? actualOnPressed = isLoading ? null : onPressed;
    final Color effectiveSideColor = actualOnPressed == null ? sideColors.withOpacity(0.5) : sideColors;

    return ElevatedButton.icon (
      icon: isLoading ?
      SizedBox(
        width: 20.r,
        height: 20.r,
        child: const CircularProgressIndicator(
          color: Colors.white,
          strokeWidth: 2.5,
        ),
      )
          : (icon ?? const SizedBox.shrink()),
      onPressed: actualOnPressed,
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: actualOnPressed == null ? color.withOpacity(0.7) : color,
        minimumSize: Size(double.infinity, 51.h),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.r),
            side: BorderSide(
              color: effectiveSideColor,
            )
        ),
      ),
      label: Text(
        isLoading ? 'LOADING...' : text,
        style: TextStyle(
          fontSize: fontSize.sp,
          color: actualOnPressed == null ? textColors.withOpacity(0.5) : textColors,
          fontWeight: FontWeight.bold,
          fontFamily:'Outfit',
        ),
      ),
    );
  }
}