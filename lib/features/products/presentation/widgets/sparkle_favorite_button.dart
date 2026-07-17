import 'package:flutter/material.dart';
import 'package:nti_ecommerce_team4/features/products/presentation/widgets/sparkle_painter.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/theme_extensions.dart';
import '../../../../core/utils/app_colors.dart';

class SparkleFavoriteButton extends StatefulWidget {
  final double size;
  const SparkleFavoriteButton({super.key, this.size = 42});

  @override
  State<SparkleFavoriteButton> createState() => _SparkleFavoriteButtonState();
}

class _SparkleFavoriteButtonState extends State<SparkleFavoriteButton>
    with SingleTickerProviderStateMixin {
  bool active = false;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 550),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() => active = !active);
    if (active) {
      _controller.forward(from: 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    final sparkColor = context.gold;
    final heartColor = AppColors.error;
    final outerSize = widget.size * 1.4; // Sparkle area
    
    return GestureDetector(
      onTap: _toggle,
      child: SizedBox(
        width: outerSize,
        height: outerSize,
        child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            AnimatedBuilder(
              animation: _controller,
              builder: (context, _) => CustomPaint(
                size: Size(outerSize, outerSize),
                painter: SparklePainter(
                  progress: _controller.value,
                  color: sparkColor,
                ),
              ),
            ),
            Container(
              width: widget.size,
              height: widget.size,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.8),
                shape: BoxShape.circle,
                border: Border.all(color: context.borderColor.withValues(alpha: 0.1)),
                boxShadow: [
                   BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Icon(
                active ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                color: active ? heartColor : AppColors.darkBackground,
                size: widget.size * 0.48,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
