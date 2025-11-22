import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tullana/getx_controller/user_api_controller.dart';
import 'package:tullana/screen/auth/verification_code_screen.dart';
import 'package:tullana/utils/app_colors.dart';
import 'package:tullana/widget/elevated_buttonA.dart';
import 'package:tullana/widget/my_text.dart';
import 'package:tullana/widget/tango_text_field.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController emailController = TextEditingController();

  String? _emailErrorText;
  bool _isLoading = false;

  final RegExp _emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  void _sendResetLink() async {
    setState(() {
      _emailErrorText = null;
    });

    final String email = emailController.text.trim();
    bool isValid = true;

    if (email.isEmpty) {
      _emailErrorText = 'Please enter your email address.';
      isValid = false;
    } else if (!_emailRegex.hasMatch(email)) {
      _emailErrorText = 'Please enter a valid email address.';
      isValid = false;
    }

    if (!isValid) {
      setState(() {});
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final UserApiController controller = Get.find<UserApiController>();
      final bool success = await controller.forgotPassword(
        email: email,
      );

      if (success) {
      } else {
      }
    } catch (e) {
      Get.snackbar("Error", "An unexpected error occurred. Please try again.", snackPosition: SnackPosition.BOTTOM);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.W_COLOR,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 33.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 43.h),
            InkWell(
              onTap: () {
                Get.back();
              },
              child: Container(
                width: 35.r,
                height: 35.r,
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
                    'images/Group333.svg',
                    fit: BoxFit.none,
                  ),
                ),
              ),
            ),

            SizedBox(height: 33.h),

            MyText(
              text: 'Forgot password?',
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.Blak_COLOR,
            ),
            SizedBox(height: 18.h),

            MyText(
              text:
              'Enter email associated with your account and we’ll send an email with instructions to reset your password',
              fontSize: 14.sp,
              maxLines: 4,
              fontWeight: FontWeight.w400,
              color: AppColors.Blak_COLOR,
            ),
            SizedBox(height: 33.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: MyText(
                text: 'Email',
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.Blak_COLOR,
              ),
            ),
            SizedBox(height: 5.h),

            TangoTextField(
              label: 'Email address',
              controller: emailController,
              errorText: _emailErrorText,
              textInputType: TextInputType.emailAddress,
            ),
            SizedBox(height: 10.h),

            SizedBox(height: 30.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 90.w),
              child: ElevatedButtonA(
                onPressed: _isLoading ? null : _sendResetLink,
                text: _isLoading ? 'SENDING...' : 'SEND',
                color: AppColors.D_COLOR,
                fontSize: 16.sp,
              ),
            ),
            SizedBox(height: 30.h),
          ],
        ),
      ),
    );
  }
}