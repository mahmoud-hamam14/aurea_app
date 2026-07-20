import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/theme_extensions.dart';
import '../../../../generated/l10n.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_colors.dart';

class AddToCartButton extends StatefulWidget {
  final VoidCallback onAdded;

  const AddToCartButton({super.key, required this.onAdded});

  @override
  State<AddToCartButton> createState() => _AddToCartButtonState();
}

class _AddToCartButtonState extends State<AddToCartButton> {
  bool added = false;

  void _tap() {
    if (added) return;
    setState(() => added = true);
    widget.onAdded();
    Future.delayed(const Duration(milliseconds: 1600), () {
      if (mounted) setState(() => added = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return SizedBox(
      height: 52.h,
      child: ElevatedButton(
        onPressed: _tap,
        style: ElevatedButton.styleFrom(
          backgroundColor: added ? context.success : context.gold,
          foregroundColor: added ? AppColors.white : context.onGold,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14.r),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 220),
              child: Icon(
                added ? Icons.check_rounded : Icons.shopping_bag_outlined,
                key: ValueKey(added),
                size: 18.sp,
              ),
            ),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                added ? "Added" : s.addToCart,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.buttonText.copyWith(
                  color: added ? AppColors.white : context.onGold,
                  fontSize: 14.5.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
