import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tullana/screen/auth/login_screen.dart';
import 'package:tullana/screen/lunch/lunch_screen2.dart';
import 'package:tullana/utils/app_colors.dart';

class LunchScreen extends StatefulWidget {
  const LunchScreen({super.key});

  @override
  State<LunchScreen> createState() => _LunchScreenState();
}

class _LunchScreenState extends State<LunchScreen> {
  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(const Duration(seconds: 3), () {
      Get.offAll(LoginScreen());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.W_COLOR,
      body: Column(
        children: [
          Container(color: AppColors.B_COLOR, height: 45.h),
          Spacer(),

          Image.asset('images/Your favorite luxury boutique 1.png'),
          Spacer(),
          Row(children: [Spacer(),Image.asset('images/7291178 1.png')]),
        ],
      ),
    );
  }
}
