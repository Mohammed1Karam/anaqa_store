import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tullana/getx_controller/user_api_controller.dart';
import 'package:tullana/screen/auth/verification_code_screen.dart';
import 'package:tullana/screen/bottom_nav/main_screen.dart';
import 'package:tullana/utils/app_colors.dart';
import 'package:tullana/widget/elevated_buttonA.dart';
import 'package:tullana/widget/my_text.dart';
import 'package:tullana/widget/tango_text_field.dart';

class CreateNewPasswordScreen extends StatefulWidget {
  const CreateNewPasswordScreen({super.key});

  @override
  State<CreateNewPasswordScreen> createState() =>
      _CreateNewPasswordScreenState();
}

class _CreateNewPasswordScreenState extends State<CreateNewPasswordScreen> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController conPasswordController = TextEditingController();
  bool obscureText = true;
  bool obscureText1 = true;
  final _formKey = GlobalKey<FormState>();

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      final UserApiController controller = Get.find<UserApiController>();
      bool success = await controller.resetPassword(
        email: GetStorage().read('email').toString(),
        token: GetStorage().read('token').toString(),
        password: passwordController.text.trim(),
        confirmPassword: conPasswordController.text.trim(),
      );

      if (success) {

        Get.bottomSheet(
          _successBottomSheet(),
          isScrollControlled: true,
        );
      }
    }
  }

  Widget _successBottomSheet() {
    return SizedBox(
      height: 313.h,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.W_COLOR,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(44.r),
            topRight: Radius.circular(44.r),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 15.h),
            CircleAvatar(
              radius: 50.r,
              backgroundColor: AppColors.W_COLOR1,
              child: SvgPicture.asset('images/Success.svg'),
            ),
            SizedBox(height: 20.h),
            MyText(
              text: "Your password has been changed",
              fontSize: 17.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.E_COLOR,
            ),
            SizedBox(height: 15.h),
            MyText(
              text: "Welcome back! Discover now!",
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.E_COLOR,
            ),
            SizedBox(height: 22.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: ElevatedButtonA(
                onPressed: () {
                  Get.offAll(() => MainScreen()); // انتقال للشاشة الرئيسية
                },
                text: 'Start Shopping',
                color: AppColors.Blak_COLOR,
                fontSize: 16.sp,
              ),
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
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 33.w),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 43.h),
              InkWell(
                onTap: () => Get.back(),
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
                text: 'Create new password',
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.Blak_COLOR,
              ),
              SizedBox(height: 18.h),
              MyText(
                text:
                'Your new password must be different from previously used password',
                fontSize: 14.sp,
                maxLines: 4,
                fontWeight: FontWeight.w400,
                color: AppColors.Blak_COLOR,
              ),
              SizedBox(height: 33.h),
              // كلمة المرور
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
                obscureText: obscureText,
                suffixText: InkWell(
                  onTap: () => setState(() => obscureText = !obscureText),
                  child: Icon(
                    obscureText
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    size: 20.r,
                    color: AppColors.S_COLOR,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10.h),
              // تأكيد كلمة المرور
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: MyText(
                  text: 'Confirm Password',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.Blak_COLOR,
                ),
              ),
              SizedBox(height: 5.h),
              TangoTextField(
                label: 'Confirm Password',
                controller: conPasswordController,
                obscureText: obscureText1,
                suffixText: InkWell(
                  onTap: () => setState(() => obscureText1 = !obscureText1),
                  child: Icon(
                    obscureText1
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    size: 20.r,
                    color: AppColors.S_COLOR,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please confirm your password';
                  }
                  if (value != passwordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),
              SizedBox(height: 30.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 90.w),
                child: ElevatedButtonA(
                  onPressed: _submit,
                  text: 'Confirm',
                  color: AppColors.Blak_COLOR,
                  fontSize: 16.sp,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
