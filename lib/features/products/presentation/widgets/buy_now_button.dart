import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/theme_extensions.dart';
import '../../../../generated/l10n.dart';

class BuyNowButton extends StatelessWidget {
  final VoidCallback onTap;

  const BuyNowButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final bg = context.isDark
        ? AppColors.darkSurfaceAlt
        : AppColors.lightTextPrimary;
    final fg = context.isDark ? AppColors.darkTextPrimary : AppColors.white;
    
    return SizedBox(
      height: 52.h,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: bg,
          foregroundColor: fg,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14.r),
          ),
        ),
        child: Text(
          s.buyNow,
          style: AppTextStyles.buttonText.copyWith(
            fontSize: 14.5.sp,
            color: fg,
          ),
        ),
      ),
    );
  }
}
