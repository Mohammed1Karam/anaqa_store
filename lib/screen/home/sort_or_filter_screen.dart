import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tullana/utils/app_colors.dart';
import 'package:tullana/widget/elevated_buttonA.dart';
import 'package:tullana/widget/my_text.dart';
import 'package:tullana/widget/tango_text_field.dart';

class SortOrFilterScreen extends StatefulWidget {
  const SortOrFilterScreen({super.key});

  @override
  State<SortOrFilterScreen> createState() => _SortOrFilterScreenState();
}

class _SortOrFilterScreenState extends State<SortOrFilterScreen> {
  TextEditingController searchController = TextEditingController();
  final List<Map<String, dynamic>> products = [
    {
      "image": "https://images.unsplash.com/photo-1520975918318-3f124d18a3e3",
      "brand": "Tullana Brand",
      "description": "Brown Dress set summer vibes with Bag and Hat.",
      "price": "40.000",
    },
    {
      "image": "https://images.unsplash.com/photo-1521572163474-6864f9cf17ab",
      "brand": "Tullana Brand",
      "description": "Elegant beige coat with fine accessories.",
      "price": "55.000",
    },
    {
      "image": "https://images.unsplash.com/photo-1520975918318-3f124d18a3e3",
      "brand": "Tullana Brand",
      "description": "Stylish summer outfit for modern women.",
      "price": "45.000",
    },
  ];
  Map<String, bool> makeupFilters = {
    'Face': false,
    'Eyes': false,
    'Lips': false,
    'Gift Sets': false,
  };

  final List<String> makeupOptions = ['Face', 'Eyes', 'Lips', 'Gift Sets'];

  Map<String, bool> skincareFilters = {
    'Face': false,
    'Skincare Tools': false,
    'Skincare Gift Sets': false,
    'Body': false,
  };
  final List<String> skincareOptions = [
    'Face',
    'Skincare Tools',
    'Skincare Gift Sets',
    'Body',
  ];
  Map<String, bool> hairFilters = {
    'Hair Care': false,
    'Hair Tools': false,
    'Hair Gift Sets': false,
  };
  final List<String> hairOptions = [
    'Hair Care',
    'Hair Tools',
    'Hair Gift Sets',
  ];

  Map<String, bool> nailsFilters = {'Nails': false};
  final List<String> nailsOptions = ['Nails'];
  Map<String, bool> lashesFilters = {'Lashes': false};
  final List<String> lashesOptions = ['Lashes'];
  Map<String, bool> priceRangeFilters = {
    '1 - 50 KWD': false,
    '50 - 100 KWD': false,
    '+100 KWD': false,
  };
  final List<String> priceRangeOptions = [
    '1 - 50 KWD',
    '50 - 100 KWD',
    '+100 KWD',
  ];
  Map<String, bool> specialOffersFilters = {'Special Offers': false};
  final List<String> specialOffersOptions = ['Special Offers'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.W_COLOR,
      appBar: AppBar(
        backgroundColor: AppColors.W_COLOR,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Padding(
            padding: EdgeInsets.only(left: 15.w),
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
        elevation: 0,
        centerTitle: false,
        title: MyText(
          text: "Beauty Big Sale",
          fontSize: 18.sp,
          fontWeight: FontWeight.bold,
          color: AppColors.Blak_COLOR,
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10.w),
            child: IconButton(
              onPressed: () {},
              icon: SvgPicture.asset('images/Line.svg'),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              'images/Frame 33364.png',
              width: double.infinity,
              fit: BoxFit.cover,
              height: 200.h,
            ),

            Transform.translate(
              offset: Offset(0, -50.h),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.W_COLOR,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20.r),
                    topLeft: Radius.circular(20.r),
                  ),
                ),
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 0.h),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 15.h),
                      Container(
                        height: 35.h,
                        margin: EdgeInsets.symmetric(
                          // horizontal: 16.w,
                          // vertical: 10.h,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey.shade300,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: IntrinsicHeight(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: SizedBox(
                                  child: TextButton.icon(
                                    onPressed: () {
                                      Get.bottomSheet(
                                        StatefulBuilder(
                                          builder: (context, setModalState) {
                                            return SizedBox(
                                              height: 370.h,
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: 15.w,
                                                ),
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                  color: AppColors.W_COLOR,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(
                                                              44.r,
                                                            ),
                                                        topRight:
                                                            Radius.circular(
                                                              44.r,
                                                            ),
                                                      ),
                                                ),
                                                child: SingleChildScrollView(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      SizedBox(height: 10.h),

                                                      SizedBox(height: 15.h),
                                                      CircleAvatar(
                                                        radius: 50.r,
                                                        backgroundColor:
                                                            AppColors.W_COLOR1,
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            SvgPicture.asset(
                                                              'images/Group 1000004442.svg',
                                                              height: 27.h,
                                                              fit: BoxFit.cover,
                                                            ),
                                                            Text(
                                                              'Sort',
                                                              style: TextStyle(
                                                                fontSize: 16.sp,
                                                                color: AppColors
                                                                    .E_COLOR,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(height: 20.h),

                                                      Padding(
                                                        padding:
                                                            EdgeInsets.symmetric(
                                                              horizontal: 65.w,
                                                            ),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Divider(
                                                              thickness: 0.3,
                                                              color: AppColors
                                                                  .S_COLOR1,
                                                            ),
                                                            _buildRadioLikeCheckbox(
                                                              SortOption
                                                                  .priceLowToHigh,
                                                              'Price Low to High',
                                                              setModalState,
                                                            ),
                                                            SizedBox(
                                                              height: 10.h,
                                                            ),
                                                            _buildRadioLikeCheckbox(
                                                              SortOption
                                                                  .priceHighToLow,
                                                              'Price High to Low',
                                                              setModalState, // 👈 تمرير دالة التحديث
                                                            ),
                                                            SizedBox(
                                                              height: 10.h,
                                                            ),
                                                            _buildRadioLikeCheckbox(
                                                              SortOption.latest,
                                                              'Latest',
                                                              setModalState, // 👈 تمرير دالة التحديث
                                                            ),
                                                            SizedBox(
                                                              height: 18.h,
                                                            ),

                                                            Padding(
                                                              padding:
                                                                  EdgeInsets.symmetric(
                                                                    horizontal:
                                                                        10.w,
                                                                  ),
                                                              child: ElevatedButtonA(
                                                                onPressed:
                                                                    () {},
                                                                text:
                                                                    'Show Result',
                                                                color: AppColors
                                                                    .Blak_COLOR,
                                                                fontSize: 16.sp,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                        isScrollControlled: true,
                                      ).then((value) {
                                        // هذا الجزء يحدث حالة الشاشة الأم بعد إغلاق الـ bottomSheet
                                        setState(() {
                                          // إذا كنت تحتاج إلى استخدام القيمة المرجعة، ضعها هنا
                                          // value;
                                        });
                                      });
                                    },
                                    icon: SvgPicture.asset(
                                      'images/Group 1000004442.svg',
                                    ),
                                    label: Text(
                                      'Sort',
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    style: TextButton.styleFrom(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 0.h,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              VerticalDivider(
                                width: 1.w,
                                thickness: 1,
                                indent: 10.h,
                                endIndent: 10.h,
                                color: Colors.grey.shade300,
                              ),
                              // ...
                              Expanded(
                                child: Builder(
                                  // 👈 يجب استخدام Builder هنا
                                  builder: (context) {
                                    return TextButton.icon(
                                      onPressed: () {
                                        // هنا Scaffold.of(context) يعمل لأنه يستخدم سياق Builder
                                        Scaffold.of(context).openEndDrawer();
                                      },
                                      icon: SvgPicture.asset(
                                        'images/Line22.svg',
                                      ),
                                      label: Text(
                                        'Filter',
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      style: TextButton.styleFrom(
                                        padding: EdgeInsets.symmetric(
                                          vertical: 0.h,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),

                              // ...
                            ],
                          ),
                        ),
                      ),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10.w,
                          mainAxisSpacing: 10.h,
                          childAspectRatio: 0.51,
                        ),
                        itemCount: products.length,
                        padding: EdgeInsets.symmetric(
                          horizontal: 5.w,
                          vertical: 16.h,
                        ),
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          final product = products[index];
                          return Container(
                            margin: EdgeInsets.zero,
                            color: AppColors.W_COLOR,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(0.r),
                                      child: Image.asset(
                                        'images/image (1).png',
                                        width: double.infinity,
                                        height: 164.h,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Positioned(
                                      top: 0.h,
                                      right: 0.w,
                                      child: Padding(
                                        padding: EdgeInsets.all(8.w),
                                        child: CircleAvatar(
                                          radius: 14.r,
                                          backgroundColor: Colors.white,
                                          child: Icon(
                                            Icons.favorite_border,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 0.h,
                                      left: 0.w,
                                      child: Container(
                                        height: 20.h,
                                        width: 120.w,
                                        color: AppColors.Blak_COLOR,
                                        child: Center(
                                          child: MyText(
                                            text: 'Only ( 2 ) left',
                                            fontSize: 11.sp,
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.W_COLOR,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 0.h,
                                      right: 0.w,
                                      child: Container(
                                        height: 20.h,
                                        width: 30.w,
                                        color: AppColors.R_COLOR,
                                        child: Center(
                                          child: MyText(
                                            text: '10%',
                                            fontSize: 11.sp,
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.W_COLOR,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 8.w,
                                      vertical: 3.h,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          children: [
                                            Text(
                                              product['brand'],
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 12.sp,
                                                color: Colors.black,
                                              ),
                                            ),
                                            SizedBox(height: 4.h),
                                            MyText(
                                              text: product['description'],
                                              textAlign: TextAlign.center,
                                              fontWeight: FontWeight.w400,
                                              maxLines: 2,
                                              fontSize: 11.sp,
                                              color: Colors.black54,
                                            ),
                                            SizedBox(height: 4.h),
                                            Divider(
                                              thickness: 0.5,
                                              color: Colors.black54,
                                            ),
                                            SizedBox(height: 3.h),
                                            Text(
                                              "KWD ${product['price']}",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 12.sp,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(bottom: 5.h),
                                          child: ElevatedButton.icon(
                                            onPressed: () {},
                                            icon: SvgPicture.asset(
                                              'images/Line.svg',
                                              color: AppColors.W_COLOR,
                                              height: 18.h,
                                            ),
                                            label: MyText(
                                              text: "Add to Cart",
                                              textAlign: TextAlign.center,
                                              fontWeight: FontWeight.w400,
                                              maxLines: 2,
                                              fontSize: 12.sp,
                                              color: AppColors.W_COLOR,
                                            ),
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.black,
                                              minimumSize: Size(
                                                double.infinity,
                                                30.h,
                                              ),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8.r),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      endDrawer: Padding(
        padding: EdgeInsets.only(top: 0.h),
        child: Drawer(
          width: 310.w,
          backgroundColor: AppColors.W_COLOR,
          child: Column(
            children: [
              SizedBox(height: 20.h),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 31.h,
                  ),
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: <Widget>[
                      Row(
                        children: [
                          MyText(
                            text: 'Filter',
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w700,
                            color: AppColors.Blak_COLOR,
                          ),
                          Spacer(),
                          SvgPicture.asset('images/Line22.svg', height: 25.h),
                        ],
                      ),
                      Divider(thickness: 0.5, color: Colors.black26),
                      SizedBox(height: 20.h),
                      Material(
                        elevation: 0.2,

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(54.r),
                        ),
                        child: Container(
                          height: 35.h,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(54.r),
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Search Product # or Brand',
                              hintStyle: TextStyle(
                                fontSize: 10.sp,
                                color: AppColors.S_COLOR3,
                                fontWeight: FontWeight.w400,
                              ),
                              fillColor: AppColors.W_COLOR1,
                              filled: true,
                              // أيقونة البحث على اليسار
                              prefixIcon: SvgPicture.asset(
                                'images/serc.svg',
                                fit: BoxFit.none,
                              ),

                              contentPadding: EdgeInsets.symmetric(
                                vertical: 17.h,
                                horizontal: 10.w,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(54.r),
                                ),
                                borderSide: BorderSide(
                                  color: AppColors.S_COLOR,
                                  width: 0.2,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(54.r),
                                ),
                                borderSide: BorderSide(
                                  color: AppColors.S_COLOR,
                                  width: 0.2,
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(54.r),
                                ),
                                borderSide: BorderSide(
                                  color: AppColors.S_COLOR,
                                  width: 0,
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(54.r),
                                ),
                                borderSide: BorderSide(
                                  color: AppColors.R_COLOR,
                                  width: 0.2,
                                ),
                              ),
                            ),
                            textAlignVertical: TextAlignVertical.center,
                          ),
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Expanded(
                        child: StatefulBuilder(
                          builder: (context, setDrawerState) {
                            // 👈 هذا هو setDrawerState
                            return SingleChildScrollView(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 0.w,
                                  vertical: 10.h,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    MyText(
                                      text: "Makeup",
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                    Divider(
                                      thickness: 0.5,
                                      color: Colors.grey.shade300,
                                    ),
                                    GridView.builder(
                                      padding: EdgeInsets.zero,
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: makeupOptions.length,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            mainAxisSpacing: 5.h,
                                            crossAxisSpacing: 10.w,
                                            childAspectRatio: 3.5,
                                          ),
                                      itemBuilder: (context, index) {
                                        final option = makeupOptions[index];
                                        return Align(
                                          alignment: Alignment.centerLeft,
                                          // ⭐️ استخدام setDrawerState هنا ⭐️
                                          child: _buildFilterCheckbox(
                                            option,
                                            makeupFilters,
                                            setDrawerState,
                                          ),
                                        );
                                      },
                                    ),

                                    SizedBox(height: 20.h),

                                    MyText(
                                      text: "Skin Care",
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.Blak_COLOR4,
                                    ),
                                    Divider(
                                      thickness: 0.5,
                                      color: Colors.grey.shade300,
                                    ),
                                    GridView.builder(
                                      padding: EdgeInsets.zero,
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: skincareOptions.length,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            mainAxisSpacing: 5.h,
                                            crossAxisSpacing: 10.w,
                                            childAspectRatio: 3.5,
                                          ),
                                      itemBuilder: (context, index) {
                                        final option = skincareOptions[index];
                                        return Align(
                                          alignment: Alignment.centerLeft,
                                          // ⭐️ استخدام setDrawerState هنا ⭐️
                                          child: _buildFilterCheckbox(
                                            option,
                                            skincareFilters,
                                            setDrawerState,
                                          ),
                                        );
                                      },
                                    ),

                                    SizedBox(height: 20.h),

                                    MyText(
                                      text: "Hair",
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.Blak_COLOR4,
                                    ),
                                    Divider(
                                      thickness: 0.5,
                                      color: Colors.grey.shade300,
                                    ),
                                    GridView.builder(
                                      padding: EdgeInsets.zero,
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: hairOptions.length,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            mainAxisSpacing: 5.h,
                                            crossAxisSpacing: 10.w,
                                            childAspectRatio: 3.5,
                                          ),
                                      itemBuilder: (context, index) {
                                        final option = hairOptions[index];
                                        return Align(
                                          alignment: Alignment.centerLeft,
                                          // ⭐️ استخدام setDrawerState هنا ⭐️
                                          child: _buildFilterCheckbox(
                                            option,
                                            hairFilters,
                                            setDrawerState,
                                          ),
                                        );
                                      },
                                    ),

                                    SizedBox(height: 20.h),
                                    MyText(
                                      text: "Nails",
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.Blak_COLOR4,
                                    ),
                                    Divider(
                                      thickness: 0.5,
                                      color: Colors.grey.shade300,
                                    ),
                                    GridView.builder(
                                      padding: EdgeInsets.zero,
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: nailsOptions.length,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            mainAxisSpacing: 5.h,
                                            crossAxisSpacing: 10.w,
                                            childAspectRatio: 3.5,
                                          ),
                                      itemBuilder: (context, index) {
                                        final option = nailsOptions[index];
                                        return Align(
                                          alignment: Alignment.centerLeft,
                                          // ⭐️ استخدام setDrawerState هنا ⭐️
                                          child: _buildFilterCheckbox(
                                            option,
                                            nailsFilters,
                                            setDrawerState,
                                          ),
                                        );
                                      },
                                    ),

                                    SizedBox(height: 20.h),
                                    MyText(
                                      text: "Lashes",
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.Blak_COLOR4,
                                    ),
                                    Divider(
                                      thickness: 0.5,
                                      color: Colors.grey.shade300,
                                    ),
                                    GridView.builder(
                                      padding: EdgeInsets.zero,
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: lashesOptions.length,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            mainAxisSpacing: 5.h,
                                            crossAxisSpacing: 10.w,
                                            childAspectRatio: 3.5,
                                          ),
                                      itemBuilder: (context, index) {
                                        final option = lashesOptions[index];
                                        return Align(
                                          alignment: Alignment.centerLeft,
                                          // ⭐️ استخدام setDrawerState هنا ⭐️
                                          child: _buildFilterCheckbox(
                                            option,
                                            lashesFilters,
                                            setDrawerState,
                                          ),
                                        );
                                      },
                                    ),

                                    SizedBox(height: 20.h),
                                    MyText(
                                      text: "Price Range",
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.Blak_COLOR4,
                                    ),
                                    Divider(
                                      thickness: 0.5,
                                      color: Colors.grey.shade300,
                                    ),
                                    GridView.builder(
                                      padding: EdgeInsets.zero,
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: priceRangeOptions.length,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            mainAxisSpacing: 5.h,
                                            crossAxisSpacing: 10.w,
                                            childAspectRatio: 3.5,
                                          ),
                                      itemBuilder: (context, index) {
                                        final option = priceRangeOptions[index];
                                        return Align(
                                          alignment: Alignment.centerLeft,
                                          // ⭐️ استخدام setDrawerState هنا ⭐️
                                          child: _buildFilterCheckbox(
                                            option,
                                            priceRangeFilters,
                                            setDrawerState,
                                          ),
                                        );
                                      },
                                    ),
                                    SizedBox(height: 20.h),
                                    MyText(
                                      text: "Special Offers",
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.Blak_COLOR4,
                                    ),
                                    Divider(
                                      thickness: 0.5,
                                      color: Colors.grey.shade300,
                                    ),
                                    GridView.builder(
                                      padding: EdgeInsets.zero,
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: specialOffersOptions.length,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            mainAxisSpacing: 5.h,
                                            crossAxisSpacing: 10.w,
                                            childAspectRatio: 3.5,
                                          ),
                                      itemBuilder: (context, index) {
                                        final option =
                                            specialOffersOptions[index];
                                        return Align(
                                          alignment: Alignment.centerLeft,
                                          // ⭐️ استخدام setDrawerState هنا ⭐️
                                          child: _buildFilterCheckbox(
                                            option,
                                            specialOffersFilters,
                                            setDrawerState,
                                          ),
                                        );
                                      },
                                    ),
                                    SizedBox(height: 20.h),
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColors.Blak_COLOR,
                                        minimumSize: Size(
                                          double.infinity,
                                          50.h,
                                        ),
                                      ),
                                      child: Text(
                                        'Apply Filters',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16.sp,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 20.h),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  SortOption? _selectedSortOption = SortOption.latest;

  // في كلاس _SortOrFilterScreenState
  Widget _buildRadioLikeCheckbox(
    SortOption option,
    String title,
    StateSetter setModalState,
  ) {
    bool isSelected = _selectedSortOption == option;
    return InkWell(
      onTap: () {
        // 1. التحديث الفوري داخل الـ Modal
        setModalState(() {
          _selectedSortOption = option;
        });

        // لا حاجة لـ setState() هنا إلا إذا كنت تريد تحديث شيء مرئي في الشاشة الأم فورًا
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 2.h),
        child: Row(
          children: [
            Container(
              width: 17.r,
              height: 17.r,
              margin: EdgeInsets.only(right: 15.w),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1.5),
                borderRadius: BorderRadius.circular(5.r),
                color: isSelected ? Colors.black : Colors.transparent,
              ),
              child: isSelected
                  ? Icon(Icons.check, size: 13.r, color: Colors.white)
                  : null,
            ),
            MyText(
              text: title,
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterCheckbox(
    String title,
    Map<String, bool> filterMap,
    StateSetter setState,
  ) {
    bool isSelected = filterMap[title]!;
    const double offsetValue = 0.0;

    return InkWell(
      onTap: () {
        setState(() {
          filterMap[title] = !filterMap[title]!;
        });
      },
      child: Row(
        children: [
          Transform.translate(
            offset: Offset(offsetValue.w, 0),
            child: Container(
              width: 15.r,
              // حجم المربع
              height: 15.r,
              margin: EdgeInsets.only(right: 5.w),
              // مسافة بسيطة بين المربع والنص
              decoration: BoxDecoration(
                // ⭐️ حدود أرفع وزوايا مستديرة ⭐️
                border: Border.all(
                  color: Colors.black,
                  width: 1.0, // سمك أقل (يمكنك جعله 1.0)
                ),
                borderRadius: BorderRadius.circular(5.r), // انحناءة الزاوية
                color: isSelected
                    ? AppColors.Blak_COLOR
                    : Colors.transparent, // لون التعبئة عند الاختيار
              ),
              child: isSelected
                  ? Icon(Icons.check, size: 13.r, color: Colors.white)
                  : null,
            ),
          ),
          Transform.translate(
            offset: Offset(offsetValue.w, 0),
            child: SizedBox(
              width: 110.w,
              child: MyText(
                text: title,
                fontSize: 12.sp,
                maxLines: 2,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

enum SortOption { priceLowToHigh, priceHighToLow, latest }
