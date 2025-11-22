import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tullana/screen/auth/sign_up_screen.dart';
  import 'package:tullana/widget/tango_text_field.dart';

import '../../../utils/app_colors.dart';
import '../../../widget/elevated_buttonA.dart';
import '../../../widget/my_text.dart';

class AddAddresses2Screen extends StatefulWidget  {
  const AddAddresses2Screen({super.key});

  @override
  State<AddAddresses2Screen> createState() => _AddAddresses2ScreenState();
}

class _AddAddresses2ScreenState extends State<AddAddresses2Screen> {
  // متغير لتتبع نوع العنوان المُختار: Home, Office, Apartment
  String selectedAddressType = 'Home';

  // إضافة متحكمات حقول الإدخال (لإدارة حالة النص)
  final TextEditingController buildingNameController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController areaController = TextEditingController();
  final TextEditingController blockController = TextEditingController();
  final TextEditingController avenueController = TextEditingController();
  final TextEditingController buildingHouseController = TextEditingController();
  final TextEditingController postalCodeController = TextEditingController();
  final TextEditingController floorController = TextEditingController();
  final TextEditingController unitController = TextEditingController();
  final TextEditingController countryCodeController = TextEditingController(
    text: "+965",
  );
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController instructionsController = TextEditingController();

  late GoogleMapController mapController;
  final LatLng _center = const LatLng(29.3759, 47.9774); // مثال: مدينة الكويت
  //
  // final List<CountryCode> countries = [
  //   CountryCode(
  //     name: 'Kuwait',
  //     code: '+965',
  //     flagAsset: 'images/Flag_of_Kuwait 2.png',
  //   ),
  //   CountryCode(
  //     name: 'Qatar',
  //     code: '+974',
  //     flagAsset: 'images/qatarflag 1.png',
  //   ),
  //   CountryCode(name: 'UAE', code: '+971', flagAsset: 'images/emirates 1.png'),
  //   CountryCode(
  //     name: 'Bahrain',
  //     code: '+973',
  //     flagAsset: 'images/bahrainflag 1.png',
  //   ),
  //   CountryCode(
  //     name: 'KSA',
  //     code: '+966',
  //     flagAsset: 'images/Saudi Arabiaflag 2 (1).png',
  //   ),
  //   CountryCode(name: 'Oman', code: '+968', flagAsset: 'images/oman 2.png'),
  // ];
  //
  // late CountryCode selectedCountry;

  @override
  void initState() {
    super.initState();
    // تعيين الكويت كقيمة أولية افتراضية
    // selectedCountry = countries.first;
  }

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

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Widget _buildAddressTypeButton(String type, String iconPath) {
    bool isSelected = selectedAddressType == type;
    return InkWell(
      onTap: () {
        setState(() {
          selectedAddressType = type;
        });
      },
      child: Container(
        width: 105.w,
        height: 35.h,
        padding: EdgeInsets.all(0.r),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.S_COLOR4 : AppColors.W_COLOR,
          borderRadius: BorderRadius.circular(25.r),
          border: isSelected
              ? null
              : Border.all(color: AppColors.Blak_COLOR, width: 1.w),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              iconPath,
              color: isSelected ? AppColors.W_COLOR : AppColors.Blak_COLOR,
              height: 18.r,
              width: 18.r,
            ),
            SizedBox(width: 4.w),
            MyText(
              text: type,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: isSelected ? AppColors.W_COLOR : AppColors.Blak_COLOR,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddressField({
    required String labelText,
    String? hintText,
    bool optional = false,
    TextEditingController? controller,
    double? widthFactor,
  }) {
    String finalLabel = labelText;
    if (optional) {
      finalLabel += ' (Optional)';
    }

    Widget textField = TangoTextField(
      label: hintText ?? "",
      controller: controller!,
    );

    return Padding(
      padding: EdgeInsets.only(bottom: 15.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: MyText(
              text: finalLabel,
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.Blak_COLOR,
            ),
          ),
          SizedBox(height: 5.h),
          widthFactor != null
              ? SizedBox(
                  width: widthFactor * MediaQuery.of(context).size.width,
                  child: textField,
                )
              : textField,
        ],
      ),
    );
  }

  String buildingLabel = "Building/House #";
  String buildingHint = "House #";

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
              ), // افتراض مسار الأيقونة
            ),
          ),
        ),
        title: MyText(
          text: "Add New Address",
          fontSize: 18.sp,
          fontWeight: FontWeight.w700,
          color: AppColors.Blak_COLOR,
        ),
        centerTitle: true,
        backgroundColor: AppColors.W_COLOR,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 1. منطقة الخريطة (الآن قابلة للتمرير مع بقية المحتوى)
            SizedBox(
              height: 127.h,
              child: Stack(
                children: [
                  GoogleMap(
                    onMapCreated: _onMapCreated,
                    initialCameraPosition: CameraPosition(
                      target: _center,
                      zoom: 14.0,
                    ),
                    mapType: MapType.normal,
                    myLocationEnabled: true,
                    myLocationButtonEnabled: true,
                  ),
                  const Center(
                    child: Icon(
                      Icons.location_on,
                      color: Colors.red,
                      size: 40.0,
                    ),
                  ),
                ],
              ),
            ),

            // 2. نموذج إدخال العنوان
            Padding(
              padding: EdgeInsets.only(top: 15.h, left: 17.w, right: 17.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // أزرار اختيار نوع العنوان
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildAddressTypeButton('Home', 'images/Vector 212.svg'),
                      _buildAddressTypeButton('Office', 'images/1213.svg'),
                      _buildAddressTypeButton('Apartment', 'images/1213.svg'),
                    ],
                  ),
                  SizedBox(height: 25.h),

                  // حقول الإدخال المشتركة
                  _buildAddressField(
                    labelText: "Building name",
                    hintText: "Building name",
                    controller: buildingNameController,
                  ),
                  _buildAddressField(
                    labelText: "Recipient's Full name",
                    hintText: "Full name",
                    controller: fullNameController,
                  ),

                  // حقول المدينة والمنطقة
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: _buildAddressField(
                          labelText: "City name",
                          hintText: "City name",
                          widthFactor: 0.45,
                          controller: cityController,
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: _buildAddressField(
                          labelText: "Area/District",
                          optional: true,
                          hintText: "Area/District",
                          widthFactor: 0.45,
                          controller: areaController,
                        ),
                      ),
                    ],
                  ),

                  // حقول البلوك والشارع (Avenue)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: _buildAddressField(
                          labelText: "Block",
                          hintText: "Block",
                          widthFactor: 0.45,
                          controller: blockController,
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: _buildAddressField(
                          labelText: "Avenue",
                          optional: true,
                          hintText: "Avenue (Optional)",
                          widthFactor: 0.45,
                          controller: avenueController,
                        ),
                      ),
                    ],
                  ),

                  // حقول الطابق / رقم الوحدة / رقم المبنى
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // رقم المبنى/المنزل
                      Expanded(
                        child: _buildAddressField(
                          labelText: buildingLabel,
                          hintText: buildingHint,
                          widthFactor: 0.45,
                          controller: buildingHouseController,
                        ),
                      ),
                      SizedBox(width: 10.w),
                      // رمز البريد (Postal Code)
                      Expanded(
                        child: _buildAddressField(
                          labelText: "Postal code",
                          optional: true,
                          hintText: "Postal code",
                          widthFactor: 0.45,
                          controller: postalCodeController,
                        ),
                      ),
                    ],
                  ),

                  // حقول الطابق ورقم المكتب/الشقة (تظهر فقط عند اختيار Office أو Apartment)
                  if (selectedAddressType != 'Home')
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: _buildAddressField(
                            labelText: "Floor #",
                            hintText: "Floor #",
                            widthFactor: 0.45,
                            controller: floorController,
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: _buildAddressField(
                            labelText: selectedAddressType == 'Office'
                                ? "Office #"
                                : "Apartment #",
                            hintText: selectedAddressType == 'Office'
                                ? "Office #"
                                : "Apartment #",
                            widthFactor: 0.45,
                            controller: unitController,
                          ),
                        ),
                      ],
                    ),

                  // حقول الدولة ورقم الهاتف (مع Dropdown لرمز الدولة)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 15.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 5.w),
                                child: MyText(
                                  text: 'Country Code',
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.Blak_COLOR,
                                ),
                              ),
                              SizedBox(height: 5.h),

                              // Container(
                              //   height: 50.h,
                              //   padding: EdgeInsets.symmetric(horizontal: 3.w),
                              //   decoration: BoxDecoration(
                              //     // color: AppColors.Background_Color, // لون خلفية موحد
                              //     borderRadius: BorderRadius.circular(10.r),
                              //     border: Border.all(
                              //       color: AppColors.S_COLOR.withOpacity(0.3),
                              //       width: 1,
                              //     ),
                              //   ),
                              //   child: DropdownButtonHideUnderline(
                              //     child: DropdownButton<CountryCode>(
                              //       value: selectedCountry,
                              //       icon: Icon(
                              //         Icons.keyboard_arrow_down,
                              //         size: 24.r,
                              //         color: AppColors.Blak_COLOR,
                              //       ),
                              //       isExpanded: true,
                              //       style: TextStyle(
                              //         color: AppColors.Blak_COLOR,
                              //         fontSize: 14
                              //             .sp, // حجم خط أصغر ليتناسب مع الكود المقدم
                              //       ),
                              //       dropdownColor: Colors.white,
                              //       borderRadius: BorderRadius.circular(10.r),
                              //       elevation: 2,
                              //       items: countries
                              //           .map(_buildDropdownItem)
                              //           .toList(),
                              //       onChanged: (CountryCode? newValue) {
                              //         setState(() {
                              //           selectedCountry = newValue!;
                              //           countryCodeController.text =
                              //               selectedCountry.code;
                              //         });
                              //       },
                              //       // العنصر المعروض عند الإغلاق (القيمة المحددة)
                              //       selectedItemBuilder: (BuildContext context) {
                              //         return countries.map((
                              //           CountryCode country,
                              //         ) {
                              //           return Container(
                              //             alignment: Alignment.centerLeft,
                              //             child: Row(
                              //               children: [
                              //                 SizedBox(width: 3.w),
                              //                 // Placeholder for flag asset
                              //                 Image.asset(
                              //                   country.flagAsset,
                              //                   width: 24.w,
                              //                   height: 24.h,
                              //                   fit: BoxFit.contain,
                              //                   errorBuilder:
                              //                       (
                              //                         context,
                              //                         error,
                              //                         stackTrace,
                              //                       ) {
                              //                         // Fallback when image asset is missing
                              //                         return SizedBox(
                              //                           width: 20.w,
                              //                           child: const Icon(
                              //                             Icons.flag,
                              //                             color:
                              //                                 AppColors.S_COLOR,
                              //                           ),
                              //                         );
                              //                       },
                              //                 ),
                              //                 SizedBox(width: 3.w),
                              //                 Text(
                              //                   country.code,
                              //                   style: TextStyle(
                              //                     fontSize: 14.sp,
                              //                     color: AppColors.Blak_COLOR,
                              //                     fontWeight: FontWeight.w400,
                              //                   ),
                              //                 ),
                              //               ],
                              //             ),
                              //           );
                              //         }).toList();
                              //       },
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        flex: 2,
                        child: _buildAddressField(
                          labelText: "Mobile #",
                          hintText: "Mobile #",
                          controller: mobileController,
                        ),
                      ),
                    ],
                  ),

                  // حقل التعليمات الخاصة
                  _buildAddressField(
                    labelText: "Special Instructions",
                    hintText:
                        "Please Enter Special Instructions for our Driver",
                    optional: true,
                    controller: instructionsController,
                  ),

                  SizedBox(height: 20.h),
                ],
              ),
            ),

            // 3. زر "إضافة عنوان" في الأسفل
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 17.w, vertical: 20.h),
              child: ElevatedButtonAA(
                onPressed: () {
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
                          padding: EdgeInsets.all(10.r),
                          decoration: BoxDecoration(
                            color: AppColors.W_COLOR,
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SvgPicture.asset(
                                'images/Check-duotone.svg',
                                height: 85.h,
                                width: 85.w,
                                fit: BoxFit.fill,
                              ),
                              // SizedBox(height: 10.h),

                              // العنوان
                              MyText(
                                text: "Congratulations!",
                                fontSize: 22.sp,
                                fontWeight: FontWeight.w700,
                                color: AppColors.Blak_COLOR,
                              ),
                              SizedBox(height: 8.h),

                              // الرسالة
                              MyText(
                                text: "Your new address has been added.",
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                color: AppColors.S_COLOR,
                              ),
                              SizedBox(height: 20.h),

                              // زر "Thanks"
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButtonAA(
                                  onPressed: () {
                                    // إغلاق النافذة المنبثقة ثم العودة للشاشة الرئيسية (مثلاً)
                                    Get.back(); // إغلاق النافذة
                                    // Get.offAllNamed('/main'); // يمكن استخدام هذه للذهاب إلى شاشة أخرى
                                  },
                                  text: 'Thanks',
                                  color: AppColors.Blak_COLOR,
                                  // استخدام اللون الأسود للزر
                                  fontSize: 16.sp,
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
                text: 'Add Address',
                color: AppColors.Blak_COLOR,
                fontSize: 16.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
