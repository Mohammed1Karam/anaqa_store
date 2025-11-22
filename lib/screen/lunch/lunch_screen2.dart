import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
 import 'package:tullana/utils/app_colors.dart';

class LunchScreen2 extends StatefulWidget {
  const LunchScreen2({super.key});

  @override
  State<LunchScreen2> createState() => _LunchScreen2State();
}

class _LunchScreen2State extends State<LunchScreen2> {
   @override
  void initState() {
    // TODO: implement initState
     Future.delayed(const Duration(seconds: 3), () {
       // Get.offAll(LunchScreen21());

     });
     super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(color: AppColors.B_COLOR, height: 45.h),
        Spacer(),

        Image.asset('images/Your favorite luxury boutique 1.png'),
        Spacer(),
        Row(children: [Image.asset('images/7291178 1.png')]),
      ],
    );
  }
}
