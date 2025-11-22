import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tullana/screen/profile/addresses/add_addresses_2_screen.dart';

// import 'package:tullana/screen/auth/forgot_password_screen.dart'; // تم التعليق عليه لعدم استخدامه
import 'package:tullana/utils/app_colors.dart';
import 'package:tullana/widget/elevated_buttonA.dart';
import 'package:tullana/widget/my_text.dart';

class AddAddressesScreen extends StatefulWidget {
  const AddAddressesScreen({super.key});

  @override
  State<AddAddressesScreen> createState() => _AddAddressesScreenState();
}

class _AddAddressesScreenState extends State<AddAddressesScreen> {
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
    selectedAddressType = addresses.firstWhere((a) => a['isDefault'])['type'];
  }

  late GoogleMapController mapController;

  final LatLng _center = const LatLng(31.9522, 35.2332); // مثال: فلسطين

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.W_COLOR,
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.only(left: 10.w),
          child: InkWell(
            onTap: () {
              Get.back();
            },
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
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: GoogleMap(
                  onMapCreated: _onMapCreated,
                  initialCameraPosition: CameraPosition(
                    target: _center,
                    zoom: 14.0,
                  ),
                  mapType: MapType.normal,
                  // hybrid, terrain, satellite
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                ),
              ),
            ],
          ),
          Container(
            height: 140.h,
            color: AppColors.W_COLOR,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 17.w),
              child: Column(
                children: [
                  SizedBox(height: 15.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset('images/Location-filled121.svg'),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MyText(
                              text: 'AlSurra City',
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.Blak_COLOR4,
                            ),
                            MyText(
                              text: 'Block 100',
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.Blak_COLOR4,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  ElevatedButtonAA(
                    onPressed: () {
                      Get.to(AddAddresses2Screen());
                    },
                    text: 'Confirm Pin location',
                    color: AppColors.Blak_COLOR,
                  ),
                  SizedBox(height: 10.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
