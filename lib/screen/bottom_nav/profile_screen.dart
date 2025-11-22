import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // يُفترض استخدامها للتناسق
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tullana/screen/profile/order/order_screen.dart';
import 'package:tullana/screen/profile/profile_setting_screen.dart';
import 'package:tullana/screen/profile/addresses/saved_addresses_screen.dart';
import 'package:tullana/utils/app_colors.dart';
import 'package:tullana/widget/elevated_buttonA.dart';
import 'package:tullana/widget/my_text.dart';

class PofileScreen extends StatefulWidget {
  const PofileScreen({super.key});

  @override
  State<PofileScreen> createState() => _PofileScreenState();
}

class _PofileScreenState extends State<PofileScreen> {
  // دالة مساعدة لبناء عنصر القائمة (ListItem)
  Widget _buildProfileListItem({
    required String icon,
    required String title,
    required Color iconColor,
    required VoidCallback onTap,
    bool isLastItem = false,
  }) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 10.w),
            child: Row(
              children: [
                SvgPicture.asset(icon),
                SizedBox(width: 15.w),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
                Spacer(),
                title == 'Log out'
                    ? SizedBox.shrink()
                    : SvgPicture.asset('images/Arrow - Right 222.svg'),
                SizedBox(width: 7.w),
              ],
            ),
          ),
          if (!isLastItem)
            Divider(
              height: 1.h,
              thickness: 0.5,
              indent: 50.w,
              // للمطابقة مع بداية النص
              endIndent: 10.w,
              color: Colors.grey.shade300,
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // تحديد لون للخلفية، افترضت أن B_COLOR هو لون خفيف جداً
    final Color backgroundColor = AppColors.B_COLOR ?? Colors.grey.shade100;

    return Scaffold(
      backgroundColor: AppColors.W_COLOR,

      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 1. صورة البروفايل
            CircleAvatar(
              radius: 30.r,
              backgroundImage: AssetImage(
                'images/d302e4d06d9afae957b686985215270a 1.png',
              ),
              // يجب استبدال هذا بالمسار الصحيح
              backgroundColor: Colors.grey.shade300,
            ),
            SizedBox(height: 15.h),
            MyText(
              text: 'Sara AlTu',
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
            SizedBox(height: 5.h),

            MyText(
              text: 'example@gmail.com',
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
            SizedBox(height: 35.h),

            Container(
              padding: EdgeInsets.all(5.r),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15.r),
                border: Border.all(color: AppColors.S_COLOR1, width: 0.4.w),

                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 20,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  _buildProfileListItem(
                    icon: "images/user1.svg",
                    title: 'Profile Setting',
                    iconColor: Colors.black,
                    onTap: () {
                      Get.to(ProfileSettingScreen());
                    },
                  ),
                  _buildProfileListItem(
                    icon: "images/Location.svg",
                    title: 'Saved Addresses',
                    iconColor: Colors.black,
                    onTap: () {
                      Get.to(SavedAddressesScreen());
                    },
                  ),
                  _buildProfileListItem(
                    icon: "images/Order_duotone_line-1.svg",
                    title: 'Orders',
                    iconColor: Colors.black,
                    onTap: () {
                      Get.to(OrderScreen());
                    },
                  ),
                  _buildProfileListItem(
                    icon: "images/Remove_duotone-1.svg",
                    title: 'Delete Account',
                    iconColor: Colors.black,
                    onTap: ()  {
                      showDialog(
                        context: context,
                        barrierDismissible: false, // لا يمكن إغلاقها بالضغط خارجها
                        builder: (BuildContext context) {
                          return AlertDialog(
                            backgroundColor: Colors.transparent,
                            contentPadding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            content: Container(
                              width: 300.w,
                              padding: EdgeInsets.symmetric(vertical: 10.h,horizontal: 20.w),
                              decoration: BoxDecoration(
                                color: AppColors.W_COLOR,
                                borderRadius: BorderRadius.circular(20.r),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SvgPicture.asset(
                                    'images/Warning.svg',
                                    height: 85.h,
                                    width: 85.w,
                                    fit: BoxFit.fill,
                                  ),
                                  // SizedBox(height: 10.h),

                                  // العنوان
                                  MyText(
                                    text: "Delete Account ?!",
                                    fontSize: 22.sp,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.Blak_COLOR,
                                  ),
                                  SizedBox(height: 8.h),

                                  // الرسالة
                                  MyText(
                                    text: "Are you sure you want to delete your\naccount?",
                                    fontSize: 14.sp,
                                    textAlign: TextAlign.center,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.S_COLOR,
                                  ),
                                  SizedBox(height: 20.h),
                                  SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButtonAA(
                                      onPressed: () {
                                        Get.back(); // إغلاق النافذة
                                      },
                                      text: 'Yes, Delete',
                                      color: AppColors.R_COLOR,
                                      sideColors: AppColors.R_COLOR,
                                      // استخدام اللون الأسود للزر
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                  SizedBox(height: 10.h),
                                  SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButtonAA(
                                      onPressed: () {
                                        Get.back(); // إغلاق النافذة
                                      },
                                      text: 'No, Cancel',
                                      color: AppColors.W_COLOR,
                                      textColors: AppColors.Blak_COLOR,sideColors: AppColors.Blak_COLOR,
                                      // استخدام اللون الأسود للزر
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                  SizedBox(height: 5.h),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                  _buildProfileListItem(
                    icon: "images/Logout.svg",
                    title: 'Log out',
                    iconColor: Colors.black,
                    onTap: () {
                      showDialog(
                        context: context,
                        barrierDismissible: false, // لا يمكن إغلاقها بالضغط خارجها
                        builder: (BuildContext context) {
                          return AlertDialog(
                            backgroundColor: Colors.transparent,
                            contentPadding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            content: Container(
                              width: 300.w,
                              padding: EdgeInsets.symmetric(vertical: 10.h,horizontal: 20.w),
                              decoration: BoxDecoration(
                                color: AppColors.W_COLOR,
                                borderRadius: BorderRadius.circular(20.r),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SvgPicture.asset(
                                    'images/Warning.svg',
                                    height: 85.h,
                                    width: 85.w,
                                    fit: BoxFit.fill,
                                  ),
                                  // SizedBox(height: 10.h),

                                  // العنوان
                                  MyText(
                                    text: "Logout?",
                                    fontSize: 22.sp,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.Blak_COLOR,
                                  ),
                                  SizedBox(height: 8.h),

                                  // الرسالة
                                  MyText(
                                    text: "Are you sure you want to logout?",
                                    fontSize: 14.sp,
                                    textAlign: TextAlign.center,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.S_COLOR,
                                  ),
                                  SizedBox(height: 20.h),
                                  SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButtonAA(
                                      onPressed: () {
                                        Get.back(); // إغلاق النافذة
                                      },
                                      text: 'Yes, Logout',
                                      color: AppColors.R_COLOR,
                                      sideColors: AppColors.R_COLOR,
                                      // استخدام اللون الأسود للزر
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                  SizedBox(height: 10.h),
                                  SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButtonAA(
                                      onPressed: () {
                                        Get.back(); // إغلاق النافذة
                                      },
                                      text: 'No, Cancel',
                                      color: AppColors.W_COLOR,
                                      textColors: AppColors.Blak_COLOR,sideColors: AppColors.Blak_COLOR,
                                      // استخدام اللون الأسود للزر
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                  SizedBox(height: 5.h),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                    isLastItem: true, // لإزالة الـ Divider الأخير
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
