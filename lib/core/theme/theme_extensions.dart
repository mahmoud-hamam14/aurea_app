import 'package:flutter/material.dart';
import 'app_colors.dart';

extension AureaThemeX on BuildContext {
  bool get isDark => Theme.of(this).brightness == Brightness.dark;

  Color get surfaceAlt =>
      isDark ? AppColors.darkSurfaceAlt : AppColors.lightSurfaceAlt;

  Color get textMuted =>
      isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted;

  Color get borderColor => Theme.of(this).colorScheme.outline;

  Color get textPrimary => Theme.of(this).colorScheme.onSurface;

  Color get textSecondary =>
      Theme.of(this).textTheme.bodyMedium?.color ??
      AppColors.lightTextSecondary;

  Color get cardColor => Theme.of(this).colorScheme.surface;

  Color get gold => AppColors.gold;

  Color get errorColor => Theme.of(this).colorScheme.error;

  Color get onGold => isDark ? AppColors.darkBackground : AppColors.lightTextPrimary;

  Color get goldDeep {
    final hsl = HSLColor.fromColor(AppColors.gold);
    return hsl.withLightness((hsl.lightness - 0.14).clamp(0.0, 1.0)).toColor();
  }

  Color get goldPale {
    final hsl = HSLColor.fromColor(AppColors.gold);
    return hsl.withLightness((hsl.lightness + 0.28).clamp(0.0, 1.0)).toColor();
  }

  Color get success => AppColors.success;

  Color get successBg => AppColors.success.withValues(alpha: isDark ? 0.18 : 0.12);
}
