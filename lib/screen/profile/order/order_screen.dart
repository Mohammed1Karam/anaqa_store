import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tullana/screen/profile/order/order_details_screen.dart';
import 'package:tullana/utils/app_colors.dart';
import 'package:tullana/widget/my_text.dart';

enum OrderStatus { onProcess, delivered, canceled }

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  // Mock data for the orders
  final List<Map<String, dynamic>> _mockOrders = [
    {
      'id': '1518',
      'tracking': 'TU287368325',
      'date': '12/10/2025',
      'price': 'KWD 230.00',
      'status': OrderStatus.onProcess,
    },
    {
      'id': '1519',
      'tracking': 'TU287368326',
      'date': '13/10/2025',
      'price': 'KWD 150.50',
      'status': OrderStatus.delivered,
    },
    {
      'id': '1520',
      'tracking': 'TU287368327',
      'date': '14/10/2025',
      'price': 'KWD 75.00',
      'status': OrderStatus.canceled,
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
            onTap: () => Get.back(),
            child: Container(
              width: 38.w, // Increased size slightly for better tap target
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
                // Assuming 'images/Group333.svg' is a back arrow. Using standard icon as fallback if SVG is missing.
                child: SvgPicture.asset(
                  'images/Group333.svg',
                  fit: BoxFit.none,
                ),
                // Alternative if SVG path is not valid:
                // child: const Icon(Icons.arrow_back_ios_new, size: 18, color: AppColors.Blak_COLOR),
              ),
            ),
          ),
        ),
        title: MyText(
          text: "Orders",
          fontSize: 18.sp,
          fontWeight: FontWeight.w700,
          color: AppColors.Blak_COLOR,
        ),
        centerTitle: false,
        backgroundColor: AppColors.W_COLOR,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        itemCount: _mockOrders.length,
        itemBuilder: (context, index) {
          final order = _mockOrders[index];
          return Padding(
            padding: EdgeInsets.only(bottom: 15.h),
            child: OrderCard(
              orderNumber: order['id'],
              trackingNumber: order['tracking'],
              placedDate: order['date'],
              totalPrice: order['price'],
              status: order['status'],
              onButtonPressed: () {
                Get.to(OrderDetailsScreen());
                // if (order['status'] == OrderStatus.onProcess) {
                //   print('Track Order ${order['id']}');
                //   Get.to(OrderDetailsScreen());
                // } else {
                //    print('View Details for Order ${order['id']}');
                //    Get.to(OrderDetailsScreen());
                //
                // }
              },
            ),
          );
        },
      ),
    );
  }
}

class OrderCard extends StatelessWidget {
  final String orderNumber;
  final String trackingNumber;
  final String placedDate;
  final String totalPrice;
  final OrderStatus status;
  final VoidCallback onButtonPressed;

  const OrderCard({
    super.key,
    required this.orderNumber,
    required this.trackingNumber,
    required this.placedDate,
    required this.totalPrice,
    required this.status,
    required this.onButtonPressed,
  });

  Color _getStatusColor() {
    switch (status) {
      case OrderStatus.onProcess:
        return AppColors.O_COLOR;
      case OrderStatus.delivered:
        return AppColors.G_COLOR;
      case OrderStatus.canceled:
        return AppColors.R_COLOR;
    }
  }

  String _getStatusText() {
    switch (status) {
      case OrderStatus.onProcess:
        return 'ON PROCESS';
      case OrderStatus.delivered:
        return 'DELIVERED';
      case OrderStatus.canceled:
        return 'CANCELED';
    }
  }

  String _getButtonText() {
    return status == OrderStatus.onProcess ? 'Track order' : 'Details';
  }

  @override
  Widget build(BuildContext context) {
    final statusColor = _getStatusColor();
    final statusText = _getStatusText();
    final buttonText = _getButtonText();

    return Container(
      padding: EdgeInsets.all(15.w),
      decoration: BoxDecoration(
        color: AppColors.W_COLOR,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.Blak_COLOR, width: 0.4.w),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Order Header (Order #1518 and Tracking #)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MyText(
                text: "Order #$orderNumber",
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.Blak_COLOR,
              ),

              Row(
                children: [
                  MyText(
                    text: "Tracking #:",
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.S_COLOR4,
                  ),
                  SizedBox(width: 5.w),
                  MyText(
                    text: trackingNumber,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.Blak_COLOR,
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 15.h),

          // Details (Placed date and Total Price)
          _buildDetailRow("Placed date :", placedDate),
          SizedBox(height: 8.h),
          _buildDetailRow("Total Price:", totalPrice),
          SizedBox(height: 15.h),

          // Status and Button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MyText(
                text: statusText,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: statusColor,
              ),
              OutlinedButton(
                onPressed: onButtonPressed,
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.Blak_COLOR, width: 0.4.w),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.r),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 5.h,
                  ),
                  foregroundColor: AppColors.Blak_COLOR,
                ),
                child: MyText(
                  text: buttonText,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.Blak_COLOR,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String title, String value) {
    return Row(
      children: [
        MyText(
          text: title,
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
}
