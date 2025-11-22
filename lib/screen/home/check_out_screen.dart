import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tullana/utils/app_colors.dart';
import 'package:tullana/widget/my_text.dart';
import 'package:tullana/widget/tango_text_field.dart';

enum PaymentMethod { card, applePay, googlePay }

enum ShippingMethod { normal, express }

class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({super.key});

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  PaymentMethod _selectedPayment = PaymentMethod.card;
  ShippingMethod _selectedShipping = ShippingMethod.normal;
  TextEditingController codeTextEditingController = TextEditingController();
  double _shippingCost = 3.00;

  final double _subtotal = 125.00;
  final double _discount = 0.00;

  double get _total {
    return _subtotal - _discount + _shippingCost;
  }

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
                child: const Icon(
                  Icons.arrow_back_ios_new,
                  size: 18,
                  color: AppColors.Blak_COLOR,
                ),
              ),
            ),
          ),
        ),
        title: MyText(
          text: "Check-out", // تم تغيير العنوان
          fontSize: 18.sp,
          fontWeight: FontWeight.w700,
          color: AppColors.Blak_COLOR,
        ),
        centerTitle: false,
        backgroundColor: AppColors.W_COLOR,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 1. Delivery Address
                  _buildSectionTitle("Delivery Address"),
                  SizedBox(height: 10.h),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 5.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.W_COLOR,
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(
                        color: AppColors.S_COLOR4.withOpacity(0.5),
                        width: 1.w,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(width: 10.w),
                            SvgPicture.asset('images/rer31.svg'),
                            SizedBox(width: 10.w),

                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      MyText(
                                        text: "Home",
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.Blak_COLOR,
                                      ),
                                      SizedBox(width: 8.w),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 6.w,
                                          vertical: 2.h,
                                        ),
                                        decoration: BoxDecoration(
                                          color: AppColors.Blak_COLOR,
                                          borderRadius: BorderRadius.circular(
                                            4.r,
                                          ),
                                        ),
                                        child: MyText(
                                          text: "Default",
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.W_COLOR,
                                        ),
                                      ),
                                      Spacer(),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: InkWell(
                                          onTap: () {
                                            print("Change Address");
                                          },
                                          child: Icon(
                                            Icons.keyboard_arrow_down_outlined,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 5.h),
                                  MyText(
                                    text:
                                        "AlSurra city, Block 100, Street 50, House 2...",
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.S_COLOR4,
                                    maxLines: 2,
                                    // overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 25.h),

                  // 2. Payment Method
                  _buildSectionTitle("Payment Method"),
                  SizedBox(height: 10.h),

                  //  SvgPicture.asset('images/Card.svg'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildPaymentButton(
                        PaymentMethod.card,
                        "Card",
                        'images/Card.svg',
                      ),
                      _buildPaymentButton(
                        PaymentMethod.applePay,
                        "Pay",
                        'images/Frame2.svg',
                      ),
                      // استخدام أيقونة مؤقتة
                      _buildPaymentButton(
                        PaymentMethod.googlePay,
                        "Pay",
                        'images/Vector123w.svg',
                      ),
                      // استخدام أيقونة مؤقتة
                    ],
                  ),
                  SizedBox(height: 25.h),

                  // 3. Shipping Method
                  _buildSectionTitle("Shipping Method"),
                  SizedBox(height: 10.h),
                  Column(
                    children: [
                      // Normal Delivery
                      _buildShippingRadio(
                        method: ShippingMethod.normal,
                        price: 3.00,
                        title: "Normal Delivery",
                        subtitle: "Delivery from 2 to 3 business days",
                      ),
                      _buildShippingRadio(
                        method: ShippingMethod.express,
                        price: 5.00,
                        title: "Express Delivery",
                        subtitle: "Delivery within ( 48 ) hours.",
                      ),
                    ],
                  ),
                  SizedBox(height: 25.h),

                  // 4. Order Summary
                  _buildSectionTitle("Order Summary"),
                  SizedBox(height: 10.h),
                  _buildOrderSummary(),
                  SizedBox(height: 20.h),

                  Row(
                    children: [
                      Expanded(
                        child: Center(
                          child: TangoTextField(
                            label: 'Enter promo code',
                            controller: codeTextEditingController,
                            prefixW: SvgPicture.asset('images/3dsda.svg',fit: BoxFit.none,),
                          ),
                        ),
                      ),
                      SizedBox(width: 10.w),
                      InkWell(
                        onTap: () {
                          print("Apply Promo Code");
                        },
                        child: Container(
                          height: 50.h,
                          width: 70.w,
                          decoration: BoxDecoration(
                            color: AppColors.Blak_COLOR,
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          alignment: Alignment.center,
                          child: MyText(
                            text: "Add",
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.W_COLOR,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                ],
              ),
            ),
          ),

          // 6. Place Order Button
          _buildPlaceOrderButton(),
        ],
      ),
    );
  }

  // --- Widget Builders ---

  Widget _buildSectionTitle(String title) {
    return MyText(
      text: title,
      fontSize: 16.sp,
      fontWeight: FontWeight.w700,
      color: AppColors.Blak_COLOR,
    );
  }

  Widget _buildPaymentButton(PaymentMethod method, String label, String icon) {
    final isSelected = _selectedPayment == method;
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: InkWell(
          onTap: () {
            setState(() {
              _selectedPayment = method;
            });
          },
          child: Container(
            height: 35.h,
            decoration: BoxDecoration(
              color: isSelected ? AppColors.Blak_COLOR : AppColors.W_COLOR,
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(
                color: isSelected
                    ? AppColors.Blak_COLOR
                    : AppColors.S_COLOR4.withOpacity(0.5),
                width: 1.w,
              ),
            ),
            alignment: Alignment.center,
            child:  Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  icon,
                  width: 15.w,
                  color: isSelected
                      ? AppColors.W_COLOR
                      : AppColors.Blak_COLOR,
                ),
                SizedBox(width: 5.w),
                MyText(
                  text: label,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: isSelected
                      ? AppColors.W_COLOR
                      : AppColors.Blak_COLOR,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildShippingRadio({
    required ShippingMethod method,
    required double price,
    required String title,
    required String subtitle,
  }) {
    final isSelected = _selectedShipping == method;

    return InkWell(
      onTap: () {
        setState(() {
          _selectedShipping = method;
          _shippingCost = price;
        });
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        child: Row(
          children: [
            Radio<ShippingMethod>(
              value: method,

              groupValue: _selectedShipping,
              onChanged: (ShippingMethod? value) {
                if (value != null) {
                  setState(() {
                    _selectedShipping = value;
                    _shippingCost = price;
                  });
                }
              },
              activeColor: AppColors.Blak_COLOR,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      MyText(
                        text: "KWD ${price.toStringAsFixed(2)} ",
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.Blak_COLOR,
                      ),
                      MyText(
                        text: title,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.S_COLOR4,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      MyText(
                        text: subtitle,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.S_COLOR4,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderSummary() {
    return Column(
      children: [
        _buildSummaryRow("Sub-total", _subtotal, false),
        SizedBox(height: 5.h),
        _buildSummaryRow("Discount", _discount, false),
        SizedBox(height: 5.h),
        _buildSummaryRow("Shipping", _shippingCost, false),
        Divider(
          color: AppColors.S_COLOR4.withOpacity(0.3),
          height: 20.h,
          thickness: 1.h,
        ),
        _buildSummaryRow("Total", _total, true),
      ],
    );
  }

  Widget _buildSummaryRow(String title, double value, bool isTotal) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        MyText(
          text: title,
          fontSize: isTotal ? 16.sp : 14.sp,
          fontWeight: isTotal ? FontWeight.w700 : FontWeight.w400,
          color: isTotal ? AppColors.Blak_COLOR : AppColors.S_COLOR4,
        ),
        MyText(
          text: "KWD ${value.toStringAsFixed(2)}",
          fontSize: isTotal ? 16.sp : 14.sp,
          fontWeight: isTotal ? FontWeight.w700 : FontWeight.w500,
          color: AppColors.Blak_COLOR,
        ),
      ],
    );
  }

  Widget _buildPlaceOrderButton() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
      width: double.infinity,
      color: AppColors.W_COLOR,
      child: InkWell(
        onTap: () {
          print("Place Order - Total: KWD ${_total.toStringAsFixed(2)}");
        },
        child: Container(
          height: 50.h,
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.Blak_COLOR,
            borderRadius: BorderRadius.circular(30.r),
          ),
          alignment: Alignment.center,
          child: MyText(
            text: "Place Order",
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.W_COLOR,
          ),
        ),
      ),
    );
  }
}
