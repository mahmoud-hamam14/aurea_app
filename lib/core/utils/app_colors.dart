// app_colors.dart
import 'package:flutter/material.dart';
/// ==========================================================
/// AppColors
/// كل الألوان اللي في تصميم الفيجما، مقسّمة Light / Dark
/// الأسماء دلالية (semantic) عشان تعرف تستخدم اللون الصح
/// في المكان الصح من غير ما تفكر في الـ hex value
/// ==========================================================


class AppColors {
  AppColors._();

  // ---------- اللون الأساسي (ثابت في الوضعين) ----------
  static const gold = Color(0xFFD4AF37);
  static const goldSoft = Color(
    0x1AD4AF37,
  ); // gold بشفافية 10% (خلفية الأيقونات)

  // ---------- Light Mode ----------
  static const lightBackground = Color(0xFFFFFFFF);
  static const lightSurface = Color(0xFFF8F7F4); // خلفية الكروت
  static const lightSurfaceAlt = Color(0xFFFAF7ED); // خلفية الأيقونة الدائرية
  static const lightBorder = Color(0xFFE5E1DC);

  static const lightTextPrimary = Color(0xFF1B1C1C); // نص أساسي/عناوين
  static const lightTextSecondary = Color(0xFF6B7280); // نص ثانوي/وصف
  static const lightTextMuted = Color(0xFF735C00); // نص خافت (زي "Categories")

  static const lightSwitchTrackOff = Color(0xFFE2DFDE);

  // ---------- Dark Mode ----------
  static const darkBackground = Color(0xFF121212);
  static const darkSurface = Color(0xFF1E1E1E);
  static const darkSurfaceAlt = Color(0xFF2A2A28);
  static const darkBorder = Color(0xFF3A3A3A);

  static const darkTextPrimary = Color(0xFFF5F5F0);
  static const darkTextSecondary = Color(0xFFB0B0AC);
  static const darkTextMuted = Color(0xFFE8C766);

  static const darkSwitchTrackOff = Color(0xFF3A3A3A);

  // ---------- ألوان عامة (مشتركة) ----------
  static const success = Color(0xFF2E7D32);
  static const error = Color(0xFFD32F2F);
  static const white = Color(0xFFFFFFFF);

  static Color? get darkGold1 => null;

  static const Color buttonClr = Color(0xff2563EB);
  static const Color greyClr = Color(0xff9CA3AF);
  static const Color greenClr = Color(0xff22C55E);
  static const Color greyDarkClr = Color(0xff4B5563);



  static const darkGold = Color(0xFF735C00);

  static const lightBg = Color(0xFFFFFFFF);
  static const lightText = Color(0xFF1B1C1C);

  static const darkBg = Color(0xFF121212);
  static const darkText = Color(0xFFF5F5F0);


// static const Color elvatedButtonClr = Color(0xFF000000);
}