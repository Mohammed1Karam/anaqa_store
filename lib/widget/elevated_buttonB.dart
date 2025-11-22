
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/app_colors.dart';

class ElevatedButtonB extends StatelessWidget {
  final Function() onPressed;
  final String text;
  final Color color;
  final Color? textColor;



  const ElevatedButtonB({
    required this.onPressed,
    required this.text,
    required this.color,
  this.textColor=Colors. black,

  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(

      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        minimumSize: Size(52.w, 32.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.r),
        ),
      ),
      child: Text(
        text,
        style:  TextStyle(
          color: textColor,
          fontWeight: FontWeight.w500,
          fontSize: 17.sp,
          // fontFamily: Translation() == "en" ? 'ElMessiri' : "Roboto",

        ),
      ),
    );
  }
}
