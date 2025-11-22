import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // تم الإضافة
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tullana/screen/product/product_details_size_chart_screen.dart';
import 'package:tullana/screen/product/product_pictures_screen.dart';
import 'package:tullana/widget/my_text.dart'; // تم الإضافة (بافتراض المسار الصحيح)

import '../../utils/app_colors.dart';

class ProductDetailsScreen extends StatefulWidget {
  // إعادة إضافة الخصائص لتمكين تمرير اسم المنتج والسعر
  final String productName;
  final String productPrice;

  const ProductDetailsScreen({
    super.key,
    this.productName = 'Markov Celina Brand', // قيمة افتراضية
    this.productPrice = 'KWD 80.00', // قيمة افتراضية
  });

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  // بيانات وهمية للمقاسات والمؤشر
  final List<String> sizes = ['S', 'M', 'L', 'XL', '2XL', 'Free Size'];
  String? selectedSize = 'L'; // المقاس الافتراضي
  int _currentPage = 0;
  final int totalImages = 3; // عدد الصور الوهمية
  final List<Map<String, dynamic>> products = [
    {
      "image": "https://images.unsplash.com/photo-1520975918318-3f124d18a3e3",
      "brand": "Tullana Brand",
      "description": "Brown Dress set summer vibes with Bag and Hat.",
      "price": "40.000",
    },
    {
      "image": "https://images.unsplash.com/photo-1521572163474-6864f9cf17ab",
      "brand": "Tullana Brand",
      "description": "Elegant beige coat with fine accessories.",
      "price": "55.000",
    },
    {
      "image": "https://images.unsplash.com/photo-1520975918318-3f124d18a3e3",
      "brand": "Tullana Brand",
      "description": "Stylish summer outfit for modern women.",
      "price": "45.000",
    },
  ];

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
                child: SvgPicture.asset('images/Group333.svg', fit: BoxFit.none),
              ),
            ),
          ),
        ),
        title: MyText(
          text: widget.productName,
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
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 310.h,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        PageView.builder(
                          itemCount: totalImages,
                          onPageChanged: (index) {
                            setState(() {
                              _currentPage = index;
                            });
                          },
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Get.to(ProductPicturesScreen());
                              },
                              child: Image.asset(
                                'images/image 87.png',
                                fit: BoxFit.fill,
                              ),
                            );
                          },
                        ),

                        Positioned(bottom: 40.h, child: _buildPageIndicator()),
                        Positioned(
                          top: 10.h,
                          right: 10.w,
                          child: Padding(
                            padding: EdgeInsets.all(8.w),
                            child: Container(
                              // height: 34.h,
                              padding: EdgeInsets.all(4.r),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: AppColors.S_COLOR,
                                  width: 0.3.w,
                                ),
                              ),
                              child: Icon(Icons.favorite, color: Colors.red),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 25.h,
                          right: 0.w,
                          child: Container(
                            height: 20.h,
                            width: 30.w,
                            color: AppColors.R_COLOR,
                            child: Center(
                              child: MyText(
                                text: '10%',
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w600,
                                color: AppColors.W_COLOR,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0.h,
                          right: 0.w,
                          child: Container(
                            height: 20.h,
                            width: 120.w,
                            color: AppColors.Blak_COLOR,
                            child: Center(
                              child: MyText(
                                text: 'Only ( 2 ) left',
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w600,
                                color: AppColors.W_COLOR,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 20.h,
                          left: 20.w,
                          child: InkWell(
                            onTap: () async {
                              final box =
                                  context.findRenderObject() as RenderBox?;
                              await Share.share(
                                'شوف هذا الرابط 👇\nhttps://example.com',
                                subject: 'رابط مهم لك!',
                                sharePositionOrigin:
                                    box!.localToGlobal(Offset.zero) & box.size,
                              );
                            },
                            child: Container(
                              padding: EdgeInsets.all(8.r),
                              decoration: BoxDecoration(
                                color: AppColors.W_COLOR.withOpacity(0.8),
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 5.r,
                                  ),
                                ],
                              ),
                              child: SvgPicture.asset(
                                'images/Group 1000004472.svg',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    // استخدام .w و .h هنا
                    padding: EdgeInsets.only(
                      left: 32.w,
                      right: 32.w,
                      top: 12.h,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                MyText(
                                  text: widget.productName,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.sp,
                                  color: AppColors.Blak_COLOR2,
                                ),
                                MyText(
                                  text: '',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.sp,
                                  color: AppColors.Blak_COLOR2,
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                MyText(
                                  text: 'KWD 80.00',
                                  // السعر
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15.sp,
                                  color: AppColors.R_COLOR,
                                  decoration: TextDecoration.lineThrough,
                                ),
                                MyText(
                                  text: 'KWD 40.00', // السعر
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15.sp,
                                  color: AppColors.Blak_COLOR2,
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 8.h),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // استخدام MyText
                            MyText(
                              text: 'Sportswear Set for summer vibes',
                              color: AppColors.Blak_COLOR2,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                            ),
                            // استخدام MyText
                            MyText(
                              text: 'Sportswear Set for summer vibes',
                              color: AppColors.Blak_COLOR2,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ],
                        ),
                        SizedBox(height: 10.h),
                        Divider(),
                        SizedBox(height: 10.h),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // استخدام MyText
                                MyText(
                                  text: 'Size',
                                  color: AppColors.Blak_COLOR,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14.sp,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Get.to(ProductDetailsSizeChartScreen());
                                  },
                                  // استخدام MyText
                                  child: MyText(
                                    text: 'Size Chart',
                                    decoration: TextDecoration.underline,
                                    color: AppColors.Blak_COLOR,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12.sp,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10.h), // استخدام .h
                            SizedBox(
                              height: 40.h, // استخدام .h
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: sizes.length,
                                itemBuilder: (context, index) {
                                  final size = sizes[index];
                                  final isSelected = selectedSize == size;
                                  final isUnavailable = size == 'S';

                                  return GestureDetector(
                                    onTap: isUnavailable
                                        ? null
                                        : () {
                                            setState(() {
                                              selectedSize = size;
                                            });
                                          },
                                    child: Container(
                                      margin: EdgeInsets.only(right: 8.w),
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 16.w,
                                        vertical: 8.h,
                                      ),
                                      decoration: BoxDecoration(
                                        color: isSelected && !isUnavailable
                                            ? AppColors.Blak_COLOR
                                            : AppColors.W_COLOR1,
                                        border: Border.all(
                                          color: isUnavailable
                                              ? AppColors.R_COLOR
                                              : isSelected
                                              ? AppColors.Blak_COLOR
                                              : AppColors
                                                    .Blak_COLOR.withOpacity(
                                                  0.3,
                                                ),
                                          width: 0.5.r,
                                        ),
                                        borderRadius: BorderRadius.circular(
                                          20.r,
                                        ),
                                      ),
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          MyText(
                                            text: size,
                                            fontSize: 14.sp,
                                            color: isSelected && !isUnavailable
                                                ? AppColors.W_COLOR
                                                : isUnavailable
                                                ? AppColors.R_COLOR
                                                : AppColors.Blak_COLOR,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          if (isUnavailable)
                                            Positioned.fill(
                                              child: CustomPaint(
                                                painter: SlashPainter(
                                                  color: AppColors.R_COLOR,
                                                  strokeWidth: 0.9.h,
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.h),
                        Divider(),

                        SizedBox(height: 10.h),
                        ExpansionTile(
                          tilePadding: EdgeInsets.zero,
                          // استخدام MyText
                          title: MyText(
                            text: 'Product Highlights',
                            fontWeight: FontWeight.w500,
                            fontSize: 15.sp,
                            color: AppColors.Blak_COLOR,
                          ),
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(bottom: 8.h),
                              // استخدام .h
                              // استخدام MyText
                              child: MyText(
                                text:
                                    'Sportswear is no longer under culture, it is no longer indie or cobbled together as it once was. Sport is fashion today. The top is oversized in fit and style, may need to size down.Sportswear is no longer under culture, it is no longer indie or cobbled together as it once was. Sport is fashion today. The top is oversized in fit and style, may need to size down.Sportswear is no longer under culture, it is no longer indie or cobbled together as it once was. Sport is fashion today. The top is oversized in fit and style, may need to size down.. The top is oversized in fit and style, may need to size down.',
                                fontSize: 12.sp,
                                maxLines: 100,
                                fontWeight: FontWeight.w400,
                                color: AppColors.Blak_COLOR2,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.h),
                        ExpansionTile(
                          tilePadding: EdgeInsets.zero,
                          // استخدام MyText
                          title: MyText(
                            text: 'Similar Product',
                            fontWeight: FontWeight.w500,
                            fontSize: 15.sp,
                            color: AppColors.Blak_COLOR,
                          ),
                          children: <Widget>[
                            SizedBox(
                              height: 303.h, // حسب طول البطاقة
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: products.length, // عدد المنتجات
                                padding: EdgeInsets.symmetric(horizontal: 4.w),
                                itemBuilder: (context, index) {
                                  final product = products[index];
                                  return Container(
                                    width: 164.w,
                                    margin: EdgeInsets.only(right: 12.w),
                                    color: AppColors.W_COLOR,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        // الصورة + المفضلة
                                        Stack(
                                          // alignment: Alignment.topRight,
                                          children: [
                                            ClipRRect(
                                              // borderRadius: BorderRadius.only(
                                              //   topLeft: Radius.circular(12.r),
                                              //   topRight: Radius.circular(12.r),
                                              // ),
                                              child: Image.asset(
                                                'images/image (1).png',
                                                width: 164.w,
                                                height: 164.h,

                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            Positioned(
                                              top: 0.h,
                                              right: 0.w,
                                              child: Padding(
                                                padding: EdgeInsets.all(8.w),
                                                child: CircleAvatar(
                                                  radius: 14.r,
                                                  backgroundColor: Colors.white,
                                                  child: Icon(
                                                    Icons.favorite_border,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              bottom: 0.h,
                                              left: 0.w,
                                              child: Container(
                                                height: 20.h,
                                                width: 120.w,
                                                color: AppColors.Blak_COLOR,
                                                child: Center(
                                                  child: MyText(
                                                    text: 'Only ( 2 ) left',
                                                    fontSize: 11.sp,
                                                    fontWeight: FontWeight.w600,
                                                    color: AppColors.W_COLOR,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              bottom: 0.h,
                                              right: 0.w,
                                              child: Container(
                                                height: 20.h,
                                                width: 30.w,
                                                color: AppColors.R_COLOR,
                                                child: Center(
                                                  child: MyText(
                                                    text: '10%',
                                                    fontSize: 11.sp,
                                                    fontWeight: FontWeight.w600,
                                                    color: AppColors.W_COLOR,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),

                                        // النصوص
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 8.w,
                                            vertical: 3.h,
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                product['brand'],
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 12.sp,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              SizedBox(height: 4.h),
                                              MyText(
                                                text: product['description'],
                                                textAlign: TextAlign.center,
                                                fontWeight: FontWeight.w400,
                                                maxLines: 2,
                                                fontSize: 11.sp,
                                                color: Colors.black54,
                                              ),

                                              SizedBox(height: 4.h),
                                              Divider(
                                                thickness: 0.5,
                                                color: Colors.black54,
                                              ),
                                              SizedBox(height: 3.h),
                                              Text(
                                                "KWD ${product['price']}",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12.sp,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),

                                        // زر Add to cart
                                        Padding(
                                          padding: EdgeInsets.all(0.w),
                                          child: ElevatedButton.icon(
                                            onPressed: () {},
                                            icon: SvgPicture.asset(
                                              'images/Line.svg',
                                              color: AppColors.W_COLOR,
                                              height: 18.h,
                                            ),
                                            label: MyText(
                                              text: "Add to Cart",
                                              textAlign: TextAlign.center,
                                              fontWeight: FontWeight.w400,
                                              maxLines: 2,
                                              fontSize: 12.sp,
                                              color: AppColors.W_COLOR,
                                            ),
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.black,
                                              minimumSize: Size(
                                                double.infinity,
                                                30.h,
                                              ),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8.r),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 30.h),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // 3. زر الإضافة إلى السلة الثابت في الأسفل
          Container(
            decoration: BoxDecoration(
              color: AppColors.Blak_COLOR3,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.r),
                topRight: Radius.circular(20.r),
              ),
            ),
            padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 32.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset('images/Filled.svg'),
                SizedBox(width: 10.w),
                MyText(
                  text: 'Add To Cart',
                  color: AppColors.W_COLOR,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- دوال بناء المكونات ---


  Widget _buildPageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(totalImages, (index) {
        final bool isSelected = _currentPage == index;

        return Container(
          width: 14.r,
          height: 14.r,
          margin: EdgeInsets.symmetric(horizontal: 4.w),
          // استخدام .w
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            // color:  Colors.W_COLOR,
            border: Border.all(
              color: isSelected
                  ? AppColors
                        .Blak_COLOR // إطار أسود للاختيار الحالي
                  : AppColors.W_COLOR.withOpacity(0.3),
              // إطار رمادي/فاتح لغير المختار
              width: 1.5.r, // سمك الإطار
            ),
          ),
          child: isSelected
              ? Center(
                  child: Container(
                    width: 6.r, // حجم النقطة الداخلية
                    height: 6.r, // حجم النقطة الداخلية
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.Blak_COLOR, // النقطة الداخلية سوداء
                    ),
                  ),
                )
              : Center(
                  child: Container(
                    width: 6.r, // حجم النقطة الداخلية
                    height: 6.r, // حجم النقطة الداخلية
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.Blak_COLOR, // النقطة الداخلية سوداء
                    ),
                  ),
                ),
        );
      }),
    );
  }
}

class SlashPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;

  SlashPainter({required this.color, required this.strokeWidth});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round; // لجعل الأطراف مدورة

    // نرسم خطًا من الزاوية السفلية اليسرى إلى الزاوية العلوية اليمنى
    // ليتطابق مع العلامة المائلة (Non-available)
    // نبدأ من (0, size.height) وننتهي عند (size.width, 0)
    canvas.drawLine(
      Offset(0, size.height), // الزاوية السفلية اليسرى
      Offset(size.width, 0), // الزاوية العلوية اليمنى
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
