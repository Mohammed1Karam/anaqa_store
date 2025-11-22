import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tullana/screen/profile/order/order_tracking_screen.dart';
import 'package:tullana/utils/app_colors.dart'; // Assume this file exists
import 'package:tullana/widget/elevated_buttonA.dart';
import 'package:tullana/widget/my_text.dart'; // Assume this file exists

// Define mock data for a single delivered order, matching the screenshot
final Map<String, dynamic> _deliveredOrderDetails = {
  'id': '1518',
  'tracking': 'TU987362341',
  'delivered_date': '13/03/2025',
  'status_text': 'Your order is delivered',
  'shipping_address': {
    'country': 'Kuwait',
    'details':
        'AlMazaya tower, Kuwait City,\nBlock 100, Street 530, Floor 54, Office 20',
    'mobile': '+965-12345678',
  },
  'products': [
    {'name': 'Maxi Dress', 'qty': 1, 'price': 62.00},
    {'name': 'Linen Dress', 'qty': 1, 'price': 52.00},
  ],
  'sub_total': 120.00,
  'discount': 0.00,
  'shipping': 5.00,
  'total_price': 125.00,
};

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({super.key});

  String formatKWD(double price) => "KWD ${price.toStringAsFixed(2)}";

  @override
  Widget build(BuildContext context) {
    final order = _deliveredOrderDetails;

    return Scaffold(
      backgroundColor: AppColors.W_COLOR,
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.only(left: 10.w),
          child: InkWell(
            onTap: () => Get.back(),
            child: Container(
              width: 38.w,
              height: 38.h,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 1,
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Center(
                // Placeholder for back icon
                child: SvgPicture.asset(
                  'images/Group333.svg', // Use your actual SVG path
                  fit: BoxFit.none,
                ),
              ),
            ),
          ),
        ),
        title: MyText(
          text: "Order Details",
          fontSize: 18.sp,
          fontWeight: FontWeight.w700,
          color: AppColors.Blak_COLOR,
        ),
        centerTitle: false,
        backgroundColor: AppColors.W_COLOR,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                Get.to(OrderTrackingScreen());
              },
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 25.h),
                decoration: BoxDecoration(
                  color: AppColors.Blak_COLOR5, // Dark background color
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyText(
                      text: 'Your order is delivered',
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.W_COLOR,
                    ),
                    SvgPicture.asset('images/Grou23e23edd.svg'),
                  ],
                ),
              ),
            ),
            SizedBox(height: 15.h),

            Container(
              padding: EdgeInsets.all(11.r),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.r),

                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 0,
                    blurRadius: 2,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  MyText(
                    text: "Order #${order['id']}",
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.Blak_COLOR,
                  ),
                  SizedBox(height: 7.h),
                  Container(
                    width: 200.w,
                    height: 0.5.h,
                    color: AppColors.Blak_COLOR,
                  ),
                  SizedBox(height: 10.h),
                  _buildInfoRow("Tracking #", order['tracking']),
                  SizedBox(height: 5.h),
                  _buildInfoRow("Delivered  ", order['delivered_date']),
                  SizedBox(height: 20.h),

                  MyText(
                    text: "Shipping Address",
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.S_COLOR,
                  ),
                  SizedBox(height: 10.h),
                  MyText(
                    text: order['shipping_address']['country'],
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.Blak_COLOR,
                  ),
                  SizedBox(height: 5.h),
                  MyText(
                    text: order['shipping_address']['details'],
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    textAlign: TextAlign.center,
                    color: AppColors.Blak_COLOR,
                  ),
                  SizedBox(height: 5.h),
                  MyText(
                    text: "Mobile : ${order['shipping_address']['mobile']}",
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.Blak_COLOR,
                  ),
                ],
              ),
            ),

            SizedBox(height: 15.h),

            Container(
              padding: EdgeInsets.all(11.r),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.r),

                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 0,
                    blurRadius: 2,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 8.h, bottom: 8.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 3,
                          child: MyText(
                            text: "Product",
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.S_COLOR4,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: MyText(
                            text: "Qty",
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.S_COLOR4,
                            textAlign: TextAlign.right,
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: MyText(
                            text: "Price",
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.S_COLOR4,
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(color: AppColors.S_COLOR4, thickness: 0.2.h),
                  ...(_deliveredOrderDetails['products'] as List).asMap().entries.map((
                    entry,
                  ) {
                    int index = entry.key;
                    var product = entry.value;

                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 4.h),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 3,
                                child: MyText(
                                  text: product['name'],
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.Blak_COLOR,
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: MyText(
                                  text: "X ${product['qty']}",
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.Blak_COLOR,
                                  textAlign: TextAlign.right,
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: MyText(
                                  text:
                                      "KWD ${product['price'].toStringAsFixed(2)}",
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.Blak_COLOR,
                                  textAlign: TextAlign.right,
                                ),
                              ),
                            ],
                          ),

                          // اظهار الـ SizedBox والـ Divider الا اذا مو اخر عنصر
                          if (index !=
                              (_deliveredOrderDetails['products'] as List)
                                      .length -
                                  1) ...[
                            SizedBox(height: 7.h),
                            Divider(
                              color: AppColors.S_COLOR4,
                              thickness: 0.2.h,
                            ),
                          ],
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),

            SizedBox(height: 15.h),

            Container(
              padding: EdgeInsets.all(11.r),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.r),

                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 0,
                    blurRadius: 2,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Column(
                children: [
                  _buildPriceRow(
                    "Sub Total",
                    formatKWD(order['sub_total']),
                    false,
                  ),
                  SizedBox(height: 8.h),
                  _buildPriceRow(
                    "Discount",
                    formatKWD(order['discount']),
                    false,
                  ),
                  SizedBox(height: 8.h),
                  _buildPriceRow(
                    "Shipping",
                    formatKWD(order['shipping']),
                    false,
                  ),
                  Divider(
                    color: AppColors.S_COLOR4,
                    thickness: 0.5.h,
                    height: 30.h,
                  ),
                  _buildPriceRow(
                    "Total Price",
                    formatKWD(order['total_price']),
                    true,
                  ),
                ],
              ),
            ),


            SizedBox(height: 35.h),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String title, String value) {
    return Row(
      children: [
        MyText(
          text: "$title :",
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
          color: AppColors.S_COLOR4,
        ),
        SizedBox(width: 5.w),
        MyText(
          text: value,
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
          color: AppColors.Blak_COLOR,
        ),
      ],
    );
  }

  Widget _buildPriceRow(String title, String value, bool isTotal) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        // SizedBox(
        // width: 100.w),
        SizedBox(
          width: 80.w, // Aligning the title column
          child: MyText(
            text: title,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.Blak_COLOR,
            textAlign: TextAlign.start,
          ),
        ),
        SizedBox(width: 10.w),
        SizedBox(
          width: 90.w, // Aligning the value column
          child: MyText(
            text: value,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.Blak_COLOR,
            textAlign: TextAlign.start,
          ),
        ),
      ],
    );
  }
}
