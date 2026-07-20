import 'package:flutter/material.dart';
import 'package:nti_ecommerce_team4/core/routes/app_routes.dart';
import 'package:nti_ecommerce_team4/core/widgets/aurea_logo.dart';
import 'package:nti_ecommerce_team4/generated/l10n.dart';
import '../widgets/cornerPainter.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat();

    Future.delayed(const Duration(seconds: 4), () {
      if (mounted) {
        Navigator.pushReplacementNamed(context, AppRoutes.onboarding);
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final bool isWide = constraints.maxWidth > 600;

          return Stack(
            children: [
              // Corners
              Positioned(
                top: 24, left: 24,
                child: SizedBox(width: 60, height: 60, child: CustomPaint(painter: CornerPainter())),
              ),
              Positioned(
                top: 24, right: 24,
                child: SizedBox(width: 60, height: 60, child: CustomPaint(painter: CornerPainter(isRight: true))),
              ),
              Positioned(
                bottom: 24, left: 24,
                child: SizedBox(width: 60, height: 60, child: CustomPaint(painter: CornerPainter(isBottom: true))),
              ),

              Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AureaLogo(size: isWide ? 220 : 160),
                      const SizedBox(height: 60),
                      AnimatedBuilder(
                        animation: _animationController,
                        builder: (context, child) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(3, (index) {
                              final delay = index * 0.15;
                              final position = (_animationController.value - delay) % 1.0;
                              return Container(
                                margin: const EdgeInsets.symmetric(horizontal: 6),
                                width: 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: const Color(0xFFD4AF37).withValues(alpha: (position * 2 - 1).abs()),
                                ),
                              );
                            }),
                          );
                        },
                      ),
                      const SizedBox(height: 16),
                      Text(
                        s.initializingExperience,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFFC4C4C4),
                          letterSpacing: 2,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
