import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tullana/screen/home/check_out_screen.dart';
import 'package:tullana/utils/app_colors.dart';
import 'package:tullana/widget/my_text.dart';

// 1. Mock data for the Cart Items (المنتجات في السلة)
final List<Map<String, dynamic>> _cartItems = [
  {
    'brand': 'Tullana Brand',
    'name': 'Sportwear set',
    'price': 35.00,
    'size': 'Large (L)',
    'image_url': 'images/Mask2Group.png',
    'qty': 1,
  },
  {
    'brand': 'Celina Brand',
    'name': 'Turtleneck Sweater',
    'price': 50.00,
    'size': 'Medium (M)',
    'image_url': 'images/Mask2Group.png',
    'qty': 1,
  },
  {
    'brand': 'Tullana Brand',
    'name': 'Sun Screen Cream Protection',
    'price': 30.00,
    'size': null, // لا يوجد حجم لمنتج الحماية من الشمس
    'image_url': 'images/Mask2Group.png',
    'qty': 1,
  },
];

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  // يمكن استخدام هذه القائمة للحفاظ على حالة الكمية (Qty)
  final List<Map<String, dynamic>> _items = List.from(_cartItems);

  double get _subtotal {
    return _items.fold(0.0, (sum, item) => sum + (item['price'] * item['qty']));
  }

  // دالة لتحديث كمية المنتج (مثال)
  void _updateQuantity(int index, int newQty) {
    if (newQty > 0) {
      setState(() {
        _items[index]['qty'] = newQty;
      });
    }
  }

  // دالة لحذف المنتج
  void _removeItem(int index) {
    setState(() {
      _items.removeAt(index);
    });
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
                // مثال على استخدام الأيقونة بدلاً من SVG غير المتوفر
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
          text: "Your Cart",
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
          // قائمة المنتجات
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              itemCount: _items.length,
              itemBuilder: (context, index) {
                final item = _items[index];
                return CartItemCard(
                  item: item,
                  onQuantityChanged: (qty) => _updateQuantity(index, qty),
                  onRemove: () => _removeItem(index),
                );
              },
            ),
          ),

          // قسم الإجمالي و زر الدفع
          _buildCheckoutSection(context),
        ],
      ),
    );
  }

  Widget _buildCheckoutSection(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: AppColors.W_COLOR,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, -3), // ظل للأعلى
          ),
        ],
      ),
      child: Column(
        children: [
          // Subtotal Row
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              MyText(
                text: "Subtotal :",
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.S_COLOR3,
              ),
              SizedBox(width: 20.w),
              MyText(
                text: "KWD ${_subtotal.toStringAsFixed(2)}",
                fontSize: 15.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.Blak_COLOR,
              ),
            ],
          ),
          SizedBox(height: 20.h),

          // Proceed to Checkout Button
          InkWell(
            onTap: () {
              Get.to(CheckOutScreen());
            },
            child: Container(
              height: 50.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.Blak_COLOR3, // لون خلفية الزر
                borderRadius: BorderRadius.circular(30.r),
              ),
              alignment: Alignment.center,
              child: MyText(
                text: "Proceed to checkout",
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.W_COLOR,
              ),
            ),
          ),
          SizedBox(height: 10.h),
        ],
      ),
    );
  }
}

// -------------------------------------------------------------------
// 2. CartItemCard Widget (لتمثيل كل عنصر في سلة التسوق)
// -------------------------------------------------------------------

class CartItemCard extends StatelessWidget {
  final Map<String, dynamic> item;
  final Function(int) onQuantityChanged;
  final VoidCallback onRemove;

  const CartItemCard({
    super.key,
    required this.item,
    required this.onQuantityChanged,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 15.h),
      padding: EdgeInsets.all(0.w),
      decoration: BoxDecoration(
        color: AppColors.W_COLOR,
        borderRadius: BorderRadius.circular(28.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Image
          ClipRRect(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(28.r),
              topLeft: Radius.circular(28.r),
            ),
            child: Container(
              width: 100.w,
              height: 100.h,
              color: Colors.grey.shade100, // خلفية مؤقتة
              child: Image.asset(
                item['image_url'],
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    Center(child: Icon(Icons.image, size: 40)),
              ),
            ),
          ),
          SizedBox(width: 15.w),

          // 2. Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Brand and Name
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MyText(
                            text: item['brand'],
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.Blak_COLOR2,
                          ),
                          MyText(
                            text: item['name'],
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColors.Blak_COLOR2,
                          ),
                        ],
                      ),
                    ),
                    // Remove Icon (Trash Can)
                    InkWell(
                      onTap: onRemove,
                      child: Padding(
                        padding: EdgeInsets.all(4.w),
                        child: SvgPicture.asset('images/Trash.svg'),
                      ),
                    ),
                    SizedBox(width: 6.w),
                  ],
                ),
                SizedBox(height: 5.h),

                // Price and Size
                MyText(
                  text: "KWD ${item['price'].toStringAsFixed(2)}",
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.Blak_COLOR2,
                ),

                Row(
                  children: [
                    if (item['size'] != null)
                      MyText(
                        text: "Size: ${item['size']}",
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.S_COLOR4,
                      ),
                    Spacer(),
                    _buildQuantityControl(item['qty'] as int),
                    SizedBox(width: 10.w),
                  ],
                ),
                SizedBox(height: 10.h),

                // Quantity Controls
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuantityControl(int currentQty) {
    return Container(
      height: 25.h,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.S_COLOR4, width: 0.5),
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Minus Button
          _buildQtyButton(
            icon: CupertinoIcons.minus,
            onTap: () => onQuantityChanged(currentQty - 1),
            enabled: currentQty > 1,
          ),

          // Quantity Display
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: MyText(
              text: currentQty.toString(),
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.Blak_COLOR,
            ),
          ),

          // Plus Button
          _buildQtyButton(
            icon: CupertinoIcons.add,
            onTap: () => onQuantityChanged(currentQty + 1),
          ),
        ],
      ),
    );
  }

  Widget _buildQtyButton({
    required IconData icon,
    required VoidCallback onTap,
    bool enabled = true,
  }) {
    return InkWell(
      onTap: enabled ? onTap : null,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        child: Icon(
          icon,
          size: 16.w,
          color: enabled
              ? AppColors.Blak_COLOR
              : AppColors.S_COLOR4.withOpacity(0.5),
        ),
      ),
    );
  }
}
