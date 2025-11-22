import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tullana/screen/home/sort_or_filter_screen.dart';
import 'package:tullana/screen/product/product_details_screen.dart';
import 'package:tullana/widget/my_text.dart';
import '../../../utils/app_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 16.h),

            InkWell(
              onTap: () {
                Get.to(SortOrFilterScreen());
              },
              child: Image.asset(
                'images/Frame 33364.png',
                width: double.infinity,
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(height: 16.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.w),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyText(
                        text: 'Latest Collection',
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.Blak_COLOR,
                      ),
                      Container(
                        width: 155.w,
                        height: 0.5.h,
                        color: AppColors.Blak_COLOR,
                      ),
                    ],
                  ),
                  Spacer(),
                  MyText(
                    text: 'Show all',
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.S_COLOR2,
                  ),
                  SizedBox(width: 10.w),
                  SvgPicture.asset('images/Vector (1).svg'),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            SizedBox(
              height: 313.h, // حسب طول البطاقة
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: products.length, // عدد المنتجات
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                itemBuilder: (context, index) {
                  final product = products[index];
                  return InkWell(
                    onTap:() {
                      Get.to(ProductDetailsScreen());
                    },
                    child: Container(
                      width: 164.w,
                      margin: EdgeInsets.only(right: 12.w),
                      color: AppColors.W_COLOR,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // الصورة + المفضلة
                          Stack(
                            alignment: Alignment.topRight,
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
                              Padding(
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
                            ],
                          ),

                          // النصوص
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.w,
                              vertical: 3.h,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
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
                                Divider(thickness: 0.5, color: Colors.black54),
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
                                minimumSize: Size(double.infinity, 30.h),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
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
            SizedBox(height: 25.h),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),

              child: Row(
                children: [
                  Expanded(
                    child: Image.asset(
                      'images/banner 3.png',
                      height: 310.h,
                      width: 168.w,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Expanded(
                    child: Image.asset(
                      'images/banner 4.png',
                      height: 310.h,
                      width: 168.w,
                      fit: BoxFit.fill,
                    ),
                  ),
                ],
              ),
            ),
            Image.asset('images/ddd.png'),
            SizedBox(height: 16.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.w),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyText(
                        text: 'Special Offers',
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.Blak_COLOR,
                      ),
                      Container(
                        width: 155.w,
                        height: 0.5.h,
                        color: AppColors.Blak_COLOR,
                      ),
                    ],
                  ),
                  Spacer(),
                  MyText(
                    text: 'Show all',
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.S_COLOR2,
                  ),
                  SizedBox(width: 10.w),
                  SvgPicture.asset('images/Vector (1).svg'),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            SizedBox(
              height: 313.h, // حسب طول البطاقة
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
                      crossAxisAlignment: CrossAxisAlignment.center,
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
                            crossAxisAlignment: CrossAxisAlignment.center,
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
                              Divider(thickness: 0.5, color: Colors.black54),
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
                              minimumSize: Size(double.infinity, 30.h),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.r),
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
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}
