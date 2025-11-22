import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';

import '../../utils/app_colors.dart';
import 'my_text.dart';

class TangoTextField1 extends StatelessWidget {
  final String? hint;
  final String label;

  final TextInputType textInputType;
  final bool obscureText;
  final TextEditingController controller;
  final int maxLength;
  final double height1;
  final Widget? suffixText;
  final String? errorText;
  final IconData? prefixIcon;
  final Widget? prefixW;
  final Widget? suffixW;
  final Function? validation;
  final VoidCallback? onTap;
  final Color? backGColors;
  final Color? labelColors;

  TangoTextField1({
    this.hint,
    required this.label,
    this.suffixText,
    this.textInputType = TextInputType.multiline,
    this.obscureText = false,
    this.maxLength = 200,
    this.height1 = 56,
    required this.controller,
    this.errorText,
    this.prefixIcon,
    this.validation,
    this.prefixW,
    this.suffixW,
    // this.inputFormatter,
    this.onTap,
    this.backGColors = Colors.white,
    this.labelColors = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 0.6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.r)),
      child: TextFormField(
        minLines: 5,
        // any number you need (It works as the rows for the textarea)
        textCapitalization: TextCapitalization.sentences,

        maxLines: null,
        onTap: onTap,
        validator: (v) => this.validation!(v),
        keyboardType: textInputType,
        controller: controller,
        obscureText: obscureText,
        style: TextStyle(fontSize: 15.sp, fontFamily: 'Outfit'),
        decoration: InputDecoration(
          prefix: prefixW,
          suffix: suffixW,
          suffixIcon: suffixText,
          contentPadding: EdgeInsets.symmetric(
            vertical: 12.h,
            horizontal: 20.w,
          ),
          errorText: errorText,
          fillColor: backGColors,
          filled: true,
          focusedErrorBorder: InputBorder.none,
          errorStyle: TextStyle(
            color: Colors.black,
            fontFamily: 'Outfit',
            fontSize: 10.sp,
            fontWeight: FontWeight.w600,
          ),
          alignLabelWithHint: true,
          // label: MyText(
          //     text: label,
          //     fontSize: 14.sp,
          //     fontWeight: FontWeight.w400,
          //     color: labelColors!),
          hintText: label,
          hintStyle: TextStyle(
            fontSize: 11.sp,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(color: Colors.black),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(color: Colors.black),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(color: Colors.black, width: 0),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
            borderSide: BorderSide(color: Colors.black, width: 0),
          ),
        ),

        onSaved: (String? value) {
          // This optional block of code can be used to run
          // code when the user saves the form.
        },
        // onChanged:onchanged,
        // controller: controller,
      ),
    );
  }
}
