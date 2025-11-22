import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tullana/getx_controller/user_api_controller.dart'
    show UserApiController, LoginResult;
import 'package:tullana/models/user.dart';
import 'package:tullana/screen/auth/forgot_password_screen.dart';
import 'package:tullana/screen/auth/sign_up_screen.dart';
import 'package:tullana/screen/bottom_nav/main_screen.dart';
import 'package:tullana/utils/app_colors.dart';
import 'package:tullana/widget/elevated_buttonA.dart';
import 'package:tullana/widget/my_text.dart';
import 'package:tullana/widget/tango_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool obscureText = true;

  String? _emailErrorText;
  String? _passwordErrorText;
  bool _isLoading = false;

  void _handleApiError(String errorMessage) {
    String? emailErr;
    String? passwordErr;

    if (errorMessage.contains('Email not registered') ||
        errorMessage.contains('Invalid email')) {
      emailErr = 'The entered email is invalid or not registered.';
    } else if (errorMessage.contains('Incorrect password') ||
        errorMessage.contains('Password does not match')) {
      passwordErr = 'Incorrect password. Please check your password.';
    } else if (errorMessage.contains('Invalid credentials')) {
      emailErr = 'Invalid login credentials. Check your email and password.';
      passwordErr = 'Invalid login credentials. Check your email and password.';
    } else {
      // Get.snackbar(
      //   "Connection Error",
      //   errorMessage,
      //   snackPosition: SnackPosition.BOTTOM,
      // );
    }

    setState(() {
      _emailErrorText = emailErr;
      _passwordErrorText = passwordErr;
    });
  }

  void _login() async {
    setState(() {
      _emailErrorText = null;
      _passwordErrorText = null;
    });

    bool isValid = true;

    if (emailController.text.trim().isEmpty) {
      _emailErrorText = 'Please enter your email address.';
      isValid = false;
    }
    if (passwordController.text.isEmpty) {
      _passwordErrorText = 'Please enter your password.';
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
      final LoginResult result = await UserApiController().login(
        email: emailController.text.trim(),
        password: passwordController.text,
      );

      if (result.isSuccess) {
        Get.offAll(() => MainScreen());
      } else {
        _handleApiError(result.errorMessage ?? 'Unknown login failure.');
      } 
    } catch (e) {
      // Get.snackbar(
      //   "Error",
      //   "An unexpected error occurred. Please try again later. (Network error/exception)",
      //   snackPosition: SnackPosition.BOTTOM,
      // );
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
            SizedBox(height: 93.h),
            MyText(
              text: 'Log into',
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.Blak_COLOR,
            ),
            MyText(
              text: 'your account',
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.Blak_COLOR,
            ),
            SizedBox(height: 26.h),
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
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: MyText(
                text: 'Password',
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.Blak_COLOR,
              ),
            ),
            SizedBox(height: 5.h),

            TangoTextField(
              label: 'Password',
              controller: passwordController,
              errorText: _passwordErrorText,
              obscureText: obscureText,
              suffixText: InkWell(
                onTap: () {
                  setState(() {
                    obscureText = !obscureText;
                  });
                },
                child: Icon(
                  obscureText
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  size: 20.r,
                  color: AppColors.S_COLOR,
                ),
              ),
            ),
            SizedBox(height: 20.h),

            Row(
              children: [
                const Spacer(),
                InkWell(
                  onTap: () {
                    Get.to(() => const ForgotPasswordScreen());
                  },
                  child: MyText(
                    text: "Forgot Password?",
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.Blak_COLOR,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ],
            ),
            SizedBox(height: 30.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 90.w),
              child: ElevatedButtonA(
                onPressed: _isLoading ? null : _login,
                text: _isLoading ? 'LOADING...' : 'LOG IN',
                color: AppColors.D_COLOR,
                fontSize: 16.sp,
              ),
            ),
            SizedBox(height: 30.h),

            Row(
              children: [
                const Spacer(),
                MyText(
                  text: 'or log in with',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.Blak_COLOR,
                ),

                const Spacer(),
              ],
            ),
            SizedBox(height: 20.h),
            Row(
              children: [
                const Spacer(),
                const Text('Social Icon 1'),
                SizedBox(width: 20.w),
                const Text('Social Icon 2'),
                const Spacer(),
              ],
            ),
            SizedBox(height: 50.h),
            Row(
              children: [
                const Spacer(),
                MyText(
                  text: 'Don’t have an account? ',
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.Blak_COLOR,
                ),
                InkWell(
                  onTap: () {
                    Get.to(() => const SignUpScreen());
                  },
                  child: MyText(
                    text: " Sign Up",
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.Blak_COLOR,
                    decoration: TextDecoration.underline,
                  ),
                ),
                const Spacer(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
