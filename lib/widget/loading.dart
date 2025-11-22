import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Colors.black.withOpacity(0.01),
      alignment: Alignment.center,
      child: Image.asset(
        'images/loading2.gif',
        width: 90.w,
        height: 90.h,
        fit: BoxFit.contain,
      ),
    );
  }
}
