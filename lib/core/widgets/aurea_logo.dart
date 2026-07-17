import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nti_ecommerce_team4/core/theme/app_colors.dart';

class AureaLogo extends StatelessWidget {
  final double size;
  final bool showText;
  final Color? color;

  const AureaLogo({
    super.key,
    this.size = 100,
    this.showText = true,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final logoColor = color ?? AppColors.gold;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            // Outer Glowing Ring
            Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: logoColor.withValues(alpha: 0.2),
                  width: size * 0.05,
                ),
              ),
            ),
            // The Crown / Diamond Shape
            Icon(
              Icons.auto_awesome_rounded,
              size: size * 0.6,
              color: logoColor,
            ),
            // Inner Core
            Positioned(
              bottom: size * 0.25,
              child: Container(
                width: size * 0.1,
                height: size * 0.1,
                decoration: BoxDecoration(
                  color: logoColor,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: logoColor.withValues(alpha: 0.5),
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        if (showText) ...[
          SizedBox(height: 12.h),
          Text(
            'AUREA',
            style: TextStyle(
              fontFamily: 'PlayfairDisplay',
              fontSize: (size * 0.25).sp,
              fontWeight: FontWeight.w700,
              color: logoColor,
              letterSpacing: 4,
            ),
          ),
          Text(
            'LUXURY REDEFINED',
            style: TextStyle(
              fontSize: (size * 0.08).sp,
              fontWeight: FontWeight.w400,
              color: Colors.grey,
              letterSpacing: 2,
            ),
          ),
        ],
      ],
    );
  }
}
