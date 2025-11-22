import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart'; // Import GetStorage
import 'package:pinput/pinput.dart';
import 'package:tullana/getx_controller/user_api_controller.dart'; // Import the controller
import 'package:tullana/screen/auth/create_new_password_screen.dart';
import 'package:tullana/utils/app_colors.dart';
import 'package:tullana/widget/elevated_buttonA.dart';
import 'package:tullana/widget/my_text.dart';

class VerificationCodeScreen extends StatefulWidget {
  final String? otp;

  const VerificationCodeScreen({super.key, this.otp});

  @override
  State<VerificationCodeScreen> createState() => _VerificationCodeScreenState();
}

class _VerificationCodeScreenState extends State<VerificationCodeScreen> {

  final TextEditingController _otpController = TextEditingController();
  final FocusNode _pinFocusNode = FocusNode();

  bool _isLoading = false;
  bool _hasError = false;
  String _errorMessage = '';

  final defaultPinTheme = PinTheme(
    width: 58.w,
    height: 58.h,
    textStyle: TextStyle(
      fontSize: 24.sp,
      color: AppColors.Blak_COLOR,
      fontWeight: FontWeight.bold,
    ),
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      border: Border.all(color: AppColors.S_COLOR1, width: 1.w),
    ),
  );

  late final focusedPinTheme = defaultPinTheme.copyDecorationWith(
    border: Border.all(color: AppColors.S_COLOR, width: 2.w),
  );

  late final errorPinTheme = defaultPinTheme.copyDecorationWith(
    border: Border.all(color: AppColors.R_COLOR, width: 2.w),
  );

  @override
  void initState() {
    super.initState();
    if (widget.otp != null) {
      _otpController.text = widget.otp!;
    }
  }

  @override
  void dispose() {
    _otpController.dispose();
    _pinFocusNode.dispose();
    super.dispose();
  }

  void _verifyCode() async {
    setState(() {
      _hasError = false;
      _errorMessage = '';
    });

    final String code = _otpController.text.trim();
    final String? email = GetStorage().read('email');

    if (email == null) {
      Get.snackbar("Error", "Email not found. Please try the forgot password process again.", snackPosition: SnackPosition.BOTTOM);
      return;
    }

    if (code.length != 4) {
      setState(() {
        _hasError = true;
        _errorMessage = 'Please enter the 4-digit code.';
      });
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final UserApiController controller = Get.find<UserApiController>();

      final bool success = await controller.verifyOtp(email: email, token: code);

      if (success) {
        Get.off(() => const CreateNewPasswordScreen());
      } else {
        setState(() {
          _hasError = true;
          _errorMessage = 'Invalid code. Please try again.';
        });
        // Snack bar message is handled inside verifyOtp
      }
    } catch (e) {
      setState(() {
        _hasError = true;
        _errorMessage = 'An error occurred during verification.';
      });
      Get.snackbar("Error", "An unexpected error occurred.", snackPosition: SnackPosition.BOTTOM);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    final String email = GetStorage().read('email') ?? 'your email address';

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
              text: 'Verification code',
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.Blak_COLOR,
            ),
            SizedBox(height: 18.h),

            MyText(
              text:
              'We have sent a verification code to $email. Please check your email inbox or Junk.',
              fontSize: 14.sp,
              maxLines: 4,
              fontWeight: FontWeight.w400,
              color: AppColors.Blak_COLOR,
            ),
            SizedBox(height: 58.h),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: Column(
                children: [
                  Pinput(
                    controller: _otpController,
                    focusNode: _pinFocusNode,
                    length: 4,
                    defaultPinTheme: defaultPinTheme,
                    focusedPinTheme: focusedPinTheme,
                    errorPinTheme: errorPinTheme,
                    errorText: _hasError ? _errorMessage : null,
                    showCursor: true,
                    onCompleted: (pin) {
                      _verifyCode();
                    },
                  ),
                ],
              ),
            ),

            SizedBox(height: 47.h),

            MyText(
              text: 'Resend in 00:10',
              fontSize: 14.sp,
              fontWeight: FontWeight.w300,
              color: AppColors.Blak_COLOR1,
            ),
            SizedBox(height: 17.h),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 90.w),
              child: ElevatedButtonA(
                onPressed: _isLoading ? null : _verifyCode,
                text: _isLoading ? 'VERIFYING...' : 'VERIFY',
                color: AppColors.D_COLOR,
                fontSize: 16.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}