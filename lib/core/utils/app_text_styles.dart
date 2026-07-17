import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


/// ==========================================================
/// AppTextStyles
/// أنماط الخطوط زي ما هي متسمّاة في الفيجما (Heading 1/2/3..)
/// بدون لون، عشان اللون يتحدد حسب الـ Theme الحالي وقت الاستخدام
/// ==========================================================
class AppTextStyles {
  AppTextStyles._();

  static const fontFamily = 'Inter';

  static TextStyle get heading1 => TextStyle(
    fontFamily: fontFamily,
    fontSize: 28.sp,
    fontWeight: FontWeight.w600,
    height: 1.2,
  );

  static TextStyle get heading2 => TextStyle(
    fontFamily: fontFamily,
    fontSize: 24.sp,
    fontWeight: FontWeight.w600,
    height: 1.25,
  );

  static TextStyle get heading3 => TextStyle(
    fontFamily: fontFamily,
    fontSize: 18.sp,
    fontWeight: FontWeight.w600,
    height: 1.3,
  );

  static TextStyle get heading4 => TextStyle(
    fontFamily: fontFamily,
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
    height: 1.3,
  );

  static TextStyle get bodyLarge => TextStyle(
    fontFamily: fontFamily,
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
    height: 1.5,
  );

  static TextStyle get bodyMedium => TextStyle(
    fontFamily: fontFamily,
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    height: 1.4,
  );

  static TextStyle get bodySmall => TextStyle(
    fontFamily: fontFamily,
    fontSize: 12.sp,
    fontWeight: FontWeight.w500,
    height: 1.3,
  );

  static TextStyle get buttonText => TextStyle(
    fontFamily: fontFamily,
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
    height: 1.2,
  );
}
