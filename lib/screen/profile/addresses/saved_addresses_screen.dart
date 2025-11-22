import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tullana/screen/profile/addresses/add_addresses_screen.dart';

// import 'package:tullana/screen/auth/forgot_password_screen.dart'; // تم التعليق عليه لعدم استخدامه
import 'package:tullana/utils/app_colors.dart';
import 'package:tullana/widget/elevated_buttonA.dart';
import 'package:tullana/widget/my_text.dart';
// import 'package:tullana/widget/tango_text_field.dart'; // تم التعليق عليه لعدم استخدامه

class SavedAddressesScreen extends StatefulWidget {
  const SavedAddressesScreen({super.key});

  @override
  State<SavedAddressesScreen> createState() => _SavedAddressesScreenState();
}

class _SavedAddressesScreenState extends State<SavedAddressesScreen> {
  // قائمة بيانات العناوين المحفوظة
  List<Map<String, dynamic>> addresses = [
    {
      'type': 'Home',
      'address': 'AlSurra city, Block 100, Street 50, Floor 3, Appartment 9',
      'isDefault': true,
    },
    {
      'type': 'Office',
      'address': 'Kuwait city, Block 100, Street 50, Floor 2, Office 5',
      'isDefault': false,
    },
    {
      'type': 'Apartment',
      'address': 'AlSurra city, Block 100, Street 50, Floor 1, Appartment 1',
      'isDefault': false,
    },
  ];

  String? selectedAddressType;

  @override
  void initState() {
    super.initState();
    // تعيين العنوان الافتراضي كـ "محدد" عند بداية التشغيل
    selectedAddressType = addresses.firstWhere((a) => a['isDefault'])['type'];
  }

  // ويدجت مساعدة لبناء كارت العنوان
  Widget _buildAddressCard(
    String type,
    String address,
    bool isDefault,
    bool isSelected,
  ) {
    return Container(
      margin: EdgeInsets.only(bottom: 15.h),
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
      decoration: BoxDecoration(
        color: AppColors.W_COLOR,
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(
          color: isSelected
              ? AppColors.D_COLOR ?? Colors.grey.shade300
              : Colors.grey.shade200,
          width: 1,
        ),
      ),
      child: InkWell(
        onTap: () {
          setState(() {
            selectedAddressType = type;
          });
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              "images/Location.svg",
              width: 17.w,
              fit: BoxFit.cover,
            ),
            SizedBox(width: 15.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      MyText(
                        text: type,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.Blak_COLOR,
                      ),
                      if (isDefault)
                        Padding(
                          padding: EdgeInsets.only(left: 8.w),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 6.w,
                              vertical: 2.h,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(5.r),
                            ),
                            child: MyText(
                              text: 'Default',
                              fontSize: 10.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.W_COLOR,
                            ),
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: 5.h),
                  MyText(
                    text: address,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey.shade600,
                    maxLines: 2,
                  ),
                ],
              ),
            ),
            SizedBox(width: 10.w),
            // أيقونة الراديو (المحدد)
            Container(
              width: 20.r,
              height: 20.r,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? Colors.black : Colors.grey,
                  width: 1.5,
                ),
                color: isSelected ? Colors.black : AppColors.W_COLOR,
              ),
              child: isSelected
                  ? Icon(Icons.circle, size: 10.r, color: AppColors.W_COLOR)
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.W_COLOR,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 53.h),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Padding(
                      padding: EdgeInsets.only(left: 0.w),
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
                            'images/Group333.svg', // يُفترض وجود هذا الملف
                            fit: BoxFit.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 20.w),
                  MyText(
                    text: "Saved Addresses",
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.Blak_COLOR,
                  ),
                ],
              ),
              SizedBox(height: 13.h),
              Divider(thickness: 0.5, color: AppColors.S_COLOR1),
              SizedBox(height: 80.h),

              // قائمة العناوين المحفوظة
              ...addresses.map((address) {
                return _buildAddressCard(
                  address['type']!,
                  address['address']!,
                  address['isDefault']!,
                  address['type'] == selectedAddressType,
                );
              }).toList(),

              Padding(
                padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 30.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          // تنفيذ عملية التعديل
                        },
                        style: OutlinedButton.styleFrom(
                          minimumSize: Size(double.infinity, 35.h),
                          side: BorderSide(
                            color: Colors.grey.shade300,
                            width: 1,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(55.r),
                          ),
                        ),
                        child: MyText(
                          text: 'Edit',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.Blak_COLOR,
                        ),
                      ),
                    ),
                    SizedBox(width: 15.w),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          // تنفيذ عملية التعديل
                        },
                        style: OutlinedButton.styleFrom(
                          minimumSize: Size(double.infinity, 35.h),
                          side: BorderSide(
                            color: Colors.grey.shade300,
                            width: 1,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(55.r),
                          ),
                        ),
                        child: MyText(
                          text: 'Delete',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.Blak_COLOR,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 50.h),

              OutlinedButton.icon(
                onPressed: () {
                  Get.to(AddAddressesScreen());
                },
                icon: Icon(Icons.add, color: AppColors.Blak_COLOR, size: 24.r),
                label: MyText(
                  text: 'Add New Address',
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.Blak_COLOR,
                ),
                style: OutlinedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50.h),
                  side: BorderSide(color: Colors.grey.shade300, width: 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                  backgroundColor: AppColors.W_COLOR,
                  elevation: 0.5,
                ),
              ),

              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
    );
  }
}
