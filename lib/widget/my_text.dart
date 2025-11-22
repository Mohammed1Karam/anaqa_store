import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';

import '../../utils/app_colors.dart';

class MyText extends StatelessWidget {
  final String text;
  final String? fontFamily;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;
  final int? maxLines;
  final Key? textKey;
  final TextDecoration? decoration;
  final TextDirection? textDirection;
  final TextAlign? textAlign;

  const MyText({
    required this.text,
    this.fontFamily,
    // this.fText = 'ElMessiri',
    required this.fontSize,
    required this.fontWeight,
    required this.color,
    this.maxLines,
    this.textKey,
    this.textAlign,
    this.decoration = TextDecoration.none,
    this.textDirection,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textDirection: textDirection,
      textAlign: textAlign,
      // key: key,
      maxLines: maxLines,

      // overflow: maxLines == null ? null : TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: fontSize,
        fontFamily: 'Outfit',
        fontWeight: fontWeight,
        color: color,
        overflow: TextOverflow.ellipsis,
        decoration: decoration,
        decorationColor: Colors.black,

        // decorationStyle: TextDecorationStyle.double
      ),
    );
  }
}
