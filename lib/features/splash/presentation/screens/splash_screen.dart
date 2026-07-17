import 'package:flutter/material.dart';
import 'package:nti_ecommerce_team4/core/routes/app_routes.dart';
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
    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final bool isWide = constraints.maxWidth > 600;
          final double logoSize = isWide ? 180 : 130;
          final double titleFontSize = isWide ? 64 : 48;

          return Stack(
            children: [
              // Top Corners
              Positioned(
                top: 24,
                left: 24,
                child: SizedBox(
                  width: 60,
                  height: 60,
                  child: CustomPaint(painter: CornerPainter()),
                ),
              ),
              Positioned(
                top: 24,
                right: 24,
                child: SizedBox(
                  width: 60,
                  height: 60,
                  child: CustomPaint(painter: CornerPainter(isRight: true)),
                ),
              ),
              // Bottom Corner
              Positioned(
                bottom: 24,
                left: 24,
                child: SizedBox(
                  width: 60,
                  height: 60,
                  child: CustomPaint(painter: CornerPainter(isBottom: true)),
                ),
              ),

              Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: logoSize + 10,
                            height: logoSize + 10,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: RadialGradient(
                                colors: [
                                  const Color(
                                    0xFFD4AF37,
                                  ).withValues(alpha: 0.3),
                                  const Color(0xFFD4AF37).withValues(alpha: 0),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            width: logoSize,
                            height: logoSize,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(
                                    0xFFD4AF37,
                                  ).withValues(alpha: 0.2),
                                  blurRadius: 20,
                                  spreadRadius: 5,
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                'Aurea',
                                style: TextStyle(
                                  fontFamily: 'PlayfairDisplay',
                                  fontSize: isWide ? 32 : 24,
                                  fontWeight: FontWeight.w800,
                                  color: const Color(0xFFD4AF37),
                                  letterSpacing: 2,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 40),
                      Text(
                        'AUREA',
                        style: TextStyle(
                          fontFamily: 'PlayfairDisplay',
                          fontSize: titleFontSize,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF8B7355),
                          letterSpacing: 4,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'FINE JEWELRY & ARTISTRY',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: isWide ? 18 : 14,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFFB8B8B8),
                          letterSpacing: 3,
                        ),
                      ),
                      const SizedBox(height: 60),
                      AnimatedBuilder(
                        animation: _animationController,
                        builder: (context, child) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(3, (index) {
                              final delay = index * 0.15;
                              final position =
                                  (_animationController.value - delay) % 1.0;
                              return Container(
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                ),
                                width: 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: const Color(
                                    0xFFD4AF37,
                                  ).withValues(alpha: (position * 2 - 1).abs()),
                                ),
                              );
                            }),
                          );
                        },
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'INITIALIZING EXPERIENCE',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFFC4C4C4),
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
