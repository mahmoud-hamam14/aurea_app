import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nti_ecommerce_team4/generated/l10n.dart';
import '../../../../core/theme/theme_extensions.dart';

class LogoutButton extends StatelessWidget {
  final VoidCallback onPressed;
  const LogoutButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        foregroundColor: Colors.redAccent,
        side: const BorderSide(color: Colors.redAccent, width: 1),
        minimumSize: Size(200.w, 48.h),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      ),
      onPressed: onPressed,
      icon: Icon(Icons.logout, color: Colors.redAccent, size: 20.sp),
      label: Text(
        s.logout,
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
