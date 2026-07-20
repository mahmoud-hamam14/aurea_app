import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/theme_extensions.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            Container(
              padding: EdgeInsets.all(3.r),
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: CircleAvatar(
                radius: 50.r,
                backgroundImage: const AssetImage("assets/images/user5.jpg"),
              ),
            ),
            CircleAvatar(
              radius: 16.r,
              backgroundColor: context.gold,
              child: Icon(
                Icons.edit,
                size: 16.sp,
                color: Colors.white,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        Text(
          "Aurelian Vance",
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.w700,
            fontFamily: 'PlayfairDisplay',
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          "aurelian.vance@aurea.com",
          style: TextStyle(
            color: Colors.grey,
            fontSize: 14.sp,
          ),
        ),
      ],
    );
  }
}
