import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tullana/utils/app_colors.dart';
import 'package:tullana/widget/my_text.dart';

class ProductPicturesScreen extends StatefulWidget {
  const ProductPicturesScreen({super.key});

  @override
  State<ProductPicturesScreen> createState() => _ProductPicturesScreenState();
}

class _ProductPicturesScreenState extends State<ProductPicturesScreen> {
  // Mock List of Product Images (يجب أن تستبدل هذه بمسارات صورك الحقيقية)
  final List<String> _productImages = [
    'images/image 87 (1).png', // الصورة الرئيسية
    'images/image 87 (1).png', // المصغر 1
    'images/image 87 (1).png', // المصغر 2
   ];

  // حالة تتبع الصورة المعروضة حالياً
  int _currentPage = 0;
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onImageTapped(int index) {
    setState(() {
      _currentPage = index;
    });
    // الانتقال إلى الصفحة المطلوبة في الـ PageView
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
  }

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
                // استخدام Icon بدلاً من Svg غير متوفر
                child: const Icon(Icons.arrow_back_ios_new, size: 18, color: AppColors.Blak_COLOR),
              ),
            ),
          ),
        ),
        title: MyText(
          text: 'Markov Celina Brand',
          fontSize: 18.sp,
          fontWeight: FontWeight.w700,
          color: AppColors.Blak_COLOR,
        ),
        centerTitle: true,
        backgroundColor: AppColors.W_COLOR,
        elevation: 0,

      ),
      body: Column(
        children: [
          // 1. الصورة الرئيسية القابلة للسحب (PageView)
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: _productImages.length,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
                  child: Image.asset(
                    _productImages[index],

                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) =>
                        Center(child: Icon(Icons.image, size: 100)),
                  ),
                );
              },
            ),
          ),

          // 2. مصغرات الصور (Thumbnail Gallery)
          _buildThumbnailGallery(),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }

  Widget _buildThumbnailGallery() {
    return Container(
      height: 100.h, // ارتفاع المصغرات
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _productImages.length,
        itemBuilder: (context, index) {
          final isSelected = index == _currentPage;
          return InkWell(
            onTap: () => _onImageTapped(index),
            child: Padding(
              padding: EdgeInsets.only(right: 30.w),
              child: Container(
                width: 91.w,
                height:94.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(
                    color: isSelected ? AppColors.Blak_COLOR : Colors.grey.shade300,
                    width: isSelected ? 2.0 : 1.0,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(7.r),
                  child: Image.asset(
                    _productImages[index],
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        Center(child: Icon(Icons.image_outlined, size: 30)),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}