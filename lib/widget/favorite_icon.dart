import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/app_colors.dart';

class FavoriteIcon extends StatelessWidget {
  final bool isFavorite; // <--- مهم
  final Color containerColor;
  final double containerPadding;
  final double iconSize;
  final VoidCallback onTap;

  const FavoriteIcon({
    required this.isFavorite, // <--- هنا
    this.containerColor = Colors.white,
    this.containerPadding = 3,
    this.iconSize = 25,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 40.h,
        width: 40.w,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: containerColor,
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.favorite,
          color: isFavorite ? AppColors.B_COLOR : AppColors.B_COLOR,
          size: iconSize.r,
        ),
      ),
    );
  }
}
