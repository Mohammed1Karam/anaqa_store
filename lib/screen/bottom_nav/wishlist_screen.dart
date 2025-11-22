 import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tullana/widget/my_text.dart';
 import '../../../utils/app_colors.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() =>
      _WishlistScreenState();
}

class _WishlistScreenState
    extends State<WishlistScreen>
    with SingleTickerProviderStateMixin {
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
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.w,
          mainAxisSpacing: 10.h,
          childAspectRatio: 0.53,
        ),
        itemCount: products.length,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          final product = products[index];
          return Container(
            margin: EdgeInsets.zero,
            color: AppColors.W_COLOR,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(0.r),
                      child: Image.asset(
                        'images/image (1).png',
                        width: double.infinity,
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
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 3.h,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
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
                        Padding(
                          padding: EdgeInsets.only(bottom: 5.h),
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
                ),
              ],
            ),
          );
        },
      ),

    );
  }
}
