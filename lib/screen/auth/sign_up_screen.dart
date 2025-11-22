import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tullana/getx_controller/gulf_country_getx_controller.dart';
import 'package:tullana/models/gulf_country.dart';
import 'package:tullana/screen/auth/forgot_password_screen.dart';
import 'package:tullana/utils/app_colors.dart';
import 'package:tullana/widget/elevated_buttonA.dart';
import 'package:tullana/widget/my_text.dart';
import 'package:tullana/widget/tango_text_field.dart';

class CountryCode {
  final String name;
  final String code;
  final String flagAsset;

  CountryCode({
    required this.name,
    required this.code,
    required this.flagAsset,
  });
}

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController fNameController = TextEditingController();
  TextEditingController lNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController conPasswordController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  bool obscureText = true;
  bool obscureText1 = true;
  bool isChecked = false;

  final List<CountryCode> countries = [
    CountryCode(
      name: 'Kuwait',
      code: '+965',
      flagAsset: 'images/Flag_of_Kuwait 2.png',
    ),
    CountryCode(
      name: 'Qatar',
      code: '+974',
      flagAsset: 'images/qatarflag 1.png', 
    ),
    CountryCode(name: 'UAE', code: '+971', flagAsset: 'images/emirates 1.png'),
    CountryCode(
      name: 'Bahrain',
      code: '+973',
      flagAsset: 'images/bahrainflag 1.png',
    ),
    CountryCode(
      name: 'KSA',
      code: '+966',
      flagAsset: 'images/Saudi Arabiaflag 2 (1).png',
    ),
    CountryCode(name: 'Oman', code: '+968', flagAsset: 'images/oman 2.png'),
  ];

  GulfCountryData? selectedCountry;
  final controller = Get.put(GulfCountryGetxController());

  @override
  void initState() {
    super.initState();
    controller.fetchGulfCountries();
    // selectedCountry = countries.first;
  }

  // دالة بناء عنصر القائمة المنسدلة (DropdownMenuItem)
  DropdownMenuItem<CountryCode> _buildDropdownItem(CountryCode country) {
    return DropdownMenuItem(
      value: country,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 10.w),
        child: Row(
          children: [
            Image.asset(
              country.flagAsset,
              width: 15.w,
              height: 15.h,
              fit: BoxFit.none,
            ),
            SizedBox(width: 5.w),
            Text(
              country.code,
              style: TextStyle(
                fontSize: 16.sp,
                color: AppColors.Blak_COLOR ?? Colors.black,
                fontWeight: FontWeight.w500,
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 63.h),
            MyText(
              text: 'Create ',
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
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.w),
                        child: MyText(
                          text: 'First name',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.Blak_COLOR,
                        ),
                      ),
                      SizedBox(height: 5.h),
                      TangoTextField(
                        label: 'First name',
                        controller: fNameController,
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 10.w),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.w),
                        child: MyText(
                          text: 'Last name',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.Blak_COLOR,
                        ),
                      ),
                      SizedBox(height: 5.h),
                      TangoTextField(
                        label: 'Last name',
                        controller: lNameController,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),
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

            TangoTextField(label: 'Email address', controller: emailController),

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
            SizedBox(height: 10.h),
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
              suffixText: InkWell(
                onTap: () {
                  setState(() {
                    obscureText1 = !obscureText1;
                  });
                },
                child: Icon(
                  obscureText1
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  size: 20.r,
                  color: AppColors.S_COLOR,
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 0.w),
                        child: MyText(
                          text: 'Country Code',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.Blak_COLOR,
                        ),
                      ),
                      SizedBox(height: 5.h),
                      Obx(() {
                        if (controller.isLoading.value) {
                          return Center(
                            child: SpinKitPulsingGrid(
                              color: AppColors.Blak_COLOR,
                              size: 30.r,
                            ),
                          );
                        }

                        if (controller.errorMessage.isNotEmpty) {
                          return Text(controller.errorMessage.value);
                        }

                        if (selectedCountry == null && controller.countries.isNotEmpty) {
                          selectedCountry = controller.countries.first;
                        }
                        return Container(
                          height: 45.h,
                          padding: EdgeInsets.symmetric(horizontal: 2.w),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.r),
                            border: Border.all(
                              color: Colors.grey.shade300,
                              width: 1,
                            ),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<GulfCountryData>(
                              value: selectedCountry,
                              isExpanded: true,
                              dropdownColor: Colors.white,
                              borderRadius: BorderRadius.circular(15.r),

                              icon: Icon(Icons.keyboard_arrow_down),
                              items: controller.countries.map((country) {
                                return DropdownMenuItem(
                                  value: country,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(country.dialCode ?? ''),
                                      SizedBox(width: 6.w),
                                      Text(country.countryCode ?? ''),
                                    ],
                                  ),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                setState(() => selectedCountry = newValue);
                              },
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                ),
                SizedBox(width: 10.w),

                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.w),
                        child: MyText(
                          text: 'Mobile #',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.Blak_COLOR,
                        ),
                      ),
                      SizedBox(height: 5.h),
                      TangoTextField(
                        label: 'Mobile #',
                        controller: mobileController,
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: 20.h),
            Row(
              children: [
                Checkbox(
                  value: isChecked,
                  onChanged: (value) {
                    setState(() {
                      isChecked = value ?? false;
                    });
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
                MyText(
                  text: "I agree to ",
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w300,
                  color: AppColors.Blak_COLOR,
                ),
                InkWell(
                  onTap: () {
                    Get.to(ForgotPasswordScreen());
                  },
                  child: MyText(
                    text: "Terms and conditions",
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w300,
                    color: AppColors.Blak_COLOR,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ],
            ),
            SizedBox(height: 40.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 90.w),
              child: ElevatedButtonA(
                onPressed: () {},
                text: 'SIGN UP',
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
