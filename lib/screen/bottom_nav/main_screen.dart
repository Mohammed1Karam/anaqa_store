import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tullana/screen/bottom_nav/category_screen.dart';
import 'package:tullana/screen/bottom_nav/home_screen.dart';
import 'package:tullana/screen/bottom_nav/profile_screen.dart';
import 'package:tullana/screen/bottom_nav/wishlist_screen.dart';
import 'package:tullana/screen/home/cart_screen.dart';
import '../../../utils/app_colors.dart';
import '../../../widget/my_text.dart';

class MainScreen extends StatefulWidget {
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = [
    HomeScreen(),
    CategoryScreen(),
    WishlistScreen(),
    PofileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: _buildDrawer(context),

      // ✅ إضافة الـ Drawer
      appBar: AppBar(
        backgroundColor: AppColors.W_COLOR,
        leading: IconButton(
          onPressed: () => _scaffoldKey.currentState?.openDrawer(),
          // ✅ يفتح القائمة
          icon: SvgPicture.asset('images/Group 33077.svg'),
        ),
        elevation: 0,
        centerTitle: true,
        title: _buildAppBarTitle(),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(CartScreen());
            },
            icon: SvgPicture.asset('images/Line.svg'),
          ),
        ],
      ),

      body: _pages[_selectedIndex],

      bottomNavigationBar: BottomAppBar(
        color: AppColors.W_COLOR,
        shape: const CircularNotchedRectangle(),
        child: Container(
          height: 90.h,
          color: AppColors.W_COLOR,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              buildNavItem('images/Document.svg', 'Home', 0),
              buildNavItem('images/Category Button.svg', 'Category', 1),
              buildNavItem('images/Heart.svg', 'Wishlist', 2),
              buildNavItem('images/user.svg', 'Profile', 3),
            ],
          ),
        ),
      ),
    );
  }

  /// ✅ العنوان في الـ AppBar حسب الاندكس
  Widget _buildAppBarTitle() {
    switch (_selectedIndex) {
      case 0:
        return Image.asset('images/MAIN LOGO trans 1.png', height: 30.h);
      case 1:
        return MyText(
          text: "Category",
          fontSize: 18.sp,
          fontWeight: FontWeight.bold,
          color: AppColors.Blak_COLOR,
        );
      case 2:
        return MyText(
          text: "My Wishlist",
          fontSize: 18.sp,
          fontWeight: FontWeight.bold,
          color: AppColors.Blak_COLOR,
        );
      case 3:
        return MyText(
          text: "My Profile",
          fontSize: 18.sp,
          fontWeight: FontWeight.bold,
          color: AppColors.Blak_COLOR,
        );
      default:
        return const SizedBox();
    }
  }

  Widget buildNavItem(String icon, String label, int index) {
    bool isSelected = _selectedIndex == index;

    return Expanded(
      child: InkWell(
        onTap: () => _onItemTapped(index),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              icon,
              color: !isSelected ? AppColors.S_COLOR : AppColors.Blak_COLOR,
              height: !isSelected ? 20.h : 22.h,
            ),
            SizedBox(height: 4.h),
            MyText(
              text: label,
              fontSize: !isSelected ? 12.h : 13.h,
              fontWeight: !isSelected ? FontWeight.w600 : FontWeight.w400,
              color: !isSelected ? AppColors.S_COLOR : AppColors.Blak_COLOR,
            ),
          ],
        ),
      ),
    );
  }

  /// ✅ Drawer (القائمة الجانبية)
  Widget _buildDrawer(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(30.r),
        bottomRight: Radius.circular(30.r),
      ),
      child: Drawer(
        backgroundColor: AppColors.W_COLOR,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.asset(
                    'images/Your favorite luxury boutique 1ccc.png',
                    // height: 60.h,
                  ),
                ),
                SizedBox(height: 25.h),
                Row(
                  children: [
                    Spacer(),
                    MyText(
                      text: 'View as guest or ',
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.Blak_COLOR,
                    ),
                    InkWell(
                      onTap: () {},
                      child: MyText(
                        text: " Login ",
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.Blak_COLOR,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    Spacer(),
                  ],
                ),
                SizedBox(height: 20.h),

                Row(
                  children: [
                    Expanded(
                      child: _drawerItem(
                        'images/world_2_light.svg',
                        'Switch Country',
                        0,
                      ),
                    ),
                    SvgPicture.asset('images/Flag_of_Kuwait 1.svg'),
                    SizedBox(width: 10.w),
                    SvgPicture.asset('images/Vector 9.svg'),
                  ],
                ),
                _drawerItem('images/Line12.svg', 'Privacy Policy', 0),
                _drawerItem('images/Line33.svg', 'Terms & Conditions', 1),
                _drawerItem('images/Message_light.svg', 'Support', 2),
                _drawerItem('images/ffff.svg', 'About us', 3),
                _drawerItem('images/thumb_up.svg', 'Follow Tullana ', 3),

                Spacer(),
               ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _drawerItem(
    String icon,
    String title,
    int index, {
    bool isLogout = false,
  }) {
    return ListTile(
      leading: SvgPicture.asset(
        icon,
        color: isLogout ? Colors.red : AppColors.Blak_COLOR,
      ),
      title: MyText(
        text: title,
        fontSize: 14.sp,
        color: isLogout ? Colors.red : AppColors.Blak_COLOR,
        fontWeight: FontWeight.w400,
      ),
      onTap: () {
        Navigator.pop(context);
        if (index != -1) _onItemTapped(index);
      },
    );
  }
}
class LoadingOverlay {
  static OverlayEntry? _overlayEntry;

  static void showCustomLoading() {
    final context = Get.overlayContext;

    if (context == null || _overlayEntry != null) {
      return;
    }

    _overlayEntry = OverlayEntry(
      builder: (_) => Stack(
        children: [
          Positioned.fill(
            child: Container(color: Colors.black.withOpacity(0.3)),
          ),

          Center(
            child: Container(
              height: 80.h,
              width: 70.w,
              padding: EdgeInsets.all(10.r),
              decoration: BoxDecoration(
                color: AppColors.W_COLOR,
                borderRadius: BorderRadius.circular(15.r),
              ),
              child: SpinKitPulsingGrid(color: AppColors.Blak_COLOR, size: 50.r),
            ),
          ),
        ],
      ),
    );

    Overlay.of(context, rootOverlay: true)?.insert(_overlayEntry!);
  }

  static void hideCustomLoading() {
    if (_overlayEntry != null) {
      _overlayEntry!.remove();
      _overlayEntry = null;
    }
  }
}
