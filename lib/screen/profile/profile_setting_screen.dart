import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
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

class ProfileSettingScreen extends StatefulWidget {
  const ProfileSettingScreen({super.key});

  @override
  State<ProfileSettingScreen> createState() => _ProfileSettingScreenState();
}

class _ProfileSettingScreenState extends State<ProfileSettingScreen> {
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

  late CountryCode selectedCountry;

  @override
  void initState() {
    super.initState();
    // تعيين الكويت كقيمة أولية افتراضية
    selectedCountry = countries.first;
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
                          'images/Group333.svg',
                          fit: BoxFit.none,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 20.w),
                MyText(
                  text: "Profile Setting",
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.Blak_COLOR,
                ),
              ],
            ),
            SizedBox(height: 33.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 45.r,
                      backgroundImage: AssetImage(
                        'images/d302e4d06d9afae957b686985215270a 1.png',
                      ),
                      // يجب استبدال هذا بالمسار الصحيح
                      backgroundColor: Colors.grey.shade300,
                    ),
                    Positioned(
                      bottom: 0.h,
                      right: 0.w,
                      child: SvgPicture.asset('images/3324444.svg'),
                    ),
                  ],
                ),
              ],
            ),

            SizedBox(height: 60.h),
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
                      Container(
                        height: 45.h,
                        padding: EdgeInsets.symmetric(horizontal: 2.w),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(
                            color: Colors.grey.shade300,
                            width: 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              spreadRadius: 1,
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<CountryCode>(
                            value: selectedCountry,
                            icon: Icon(
                              Icons.keyboard_arrow_down,
                              size: 24.r,
                              color: Colors.black,
                            ),
                            isExpanded: true,
                            style: TextStyle(
                              color: AppColors.Blak_COLOR ?? Colors.black,
                              fontSize: 16.sp,
                            ),

                            // التخصيص الأكثر أهمية لجعله يبدو كالصورة
                            dropdownColor: Colors.white,
                            // لون خلفية القائمة المنسدلة
                            borderRadius: BorderRadius.circular(20.r),
                            // زوايا دائرية للقائمة المفتوحة
                            elevation: 8,

                            // ظل القائمة المفتوحة
                            items: countries.map(_buildDropdownItem).toList(),

                            onChanged: (CountryCode? newValue) {
                              setState(() {
                                selectedCountry = newValue!;
                              });
                            },

                            // العنصر المعروض عند الإغلاق (القيمة المحددة)
                            selectedItemBuilder: (BuildContext context) {
                              return countries.map((CountryCode country) {
                                return Container(
                                  alignment: Alignment.centerLeft,
                                  child: Row(
                                    children: [
                                      SizedBox(width: 3.w),

                                      Image.asset(
                                        country.flagAsset,
                                        // width: 18.w,
                                        // height: 18.h,
                                        fit: BoxFit.none,
                                      ),
                                      SizedBox(width: 3.w),
                                      Text(
                                        country.code,
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          color:
                                              AppColors.Blak_COLOR ??
                                              Colors.black,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList();
                            },
                          ),
                        ),
                      ),
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

            SizedBox(height: 40.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 70.w),
              child: ElevatedButtonA(
                onPressed: () {},
                text: 'Save change',
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
