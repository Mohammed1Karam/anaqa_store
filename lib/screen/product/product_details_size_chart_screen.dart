import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // تم الإضافة
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tullana/widget/my_text.dart'; // تم الإضافة (بافتراض المسار الصحيح)

import '../../utils/app_colors.dart';

class ProductDetailsSizeChartScreen extends StatefulWidget {
  // إعادة إضافة الخصائص لتمكين تمرير اسم المنتج والسعر
  final String productName;
  final String productPrice;

  const ProductDetailsSizeChartScreen({
    super.key,
    this.productName = 'Markov Celina Brand', // قيمة افتراضية
    this.productPrice = 'KWD 80.00', // قيمة افتراضية
  });

  @override
  State<ProductDetailsSizeChartScreen> createState() =>
      _ProductDetailsSizeChartScreenState();
}

class _ProductDetailsSizeChartScreenState
    extends State<ProductDetailsSizeChartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.W_COLOR,
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.only(left: 10.w),
          child: InkWell(
            onTap: () {
              Get.back();
            },
            child: Container(
              width: 30.r,
              height: 30.r,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Center(
                child: SvgPicture.asset(
                  'images/Group333.svg',
                  fit: BoxFit.none,
                ),
              ),
            ),
          ),
        ),
        title: MyText(
          text: 'Size Chart',
          fontSize: 18.sp,
          fontWeight: FontWeight.w700,
          color: AppColors.Blak_COLOR,
        ),
        centerTitle: true,
        backgroundColor: AppColors.W_COLOR,
        elevation: 0,
      ),

      body: Column(
        children: [Image.asset('images/fffs.png', width: double.infinity)],
      ),
    );
  }
}
