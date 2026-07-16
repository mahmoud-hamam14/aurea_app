import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import 'brand_name_skip_button.dart';
import 'number_and_next_button.dart';

class OnboardingPage extends StatelessWidget {
  final int pageNumber;
  final String title;
  final String description;
  final String imageUrl;
  final VoidCallback onNext;
  final VoidCallback onSkip;

  const OnboardingPage({
    super.key,
    required this.pageNumber,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.onNext,
    required this.onSkip,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isWide = constraints.maxWidth > 800;

        return Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [AppColors.darkBackground, AppColors.white],
                  stops: const [0.0, 0.35],
                ),
              ),
            ),
            BrandNameAndSkipButton(onSkip: onSkip),
            Positioned.fill(
              child: Padding(
                padding: EdgeInsets.only(
                  top: isWide ? 100 : 80,
                  bottom: 100,
                  left: isWide ? 40 : 0,
                  right: isWide ? 40 : 0,
                ),
                child: isWide
                    ? Row(
                        children: [
                          Expanded(
                            child: _buildImageSection(),
                          ),
                          const SizedBox(width: 40),
                          Expanded(
                            child: _buildTextSection(context, isWide),
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          Expanded(
                            flex: 2,
                            child: _buildImageSection(),
                          ),
                          Expanded(
                            flex: 1,
                            child: _buildTextSection(context, isWide),
                          ),
                        ],
                      ),
              ),
            ),
            NumberAndNextButton(pageNumber: pageNumber, onNext: onNext),
          ],
        );
      },
    );
  }

  Widget _buildImageSection() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: AppColors.white,
            boxShadow: [
              BoxShadow(
                color: AppColors.darkTextSecondary.withValues(alpha: 0.3),
                blurRadius: 20,
                spreadRadius: 5,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(imageUrl, fit: BoxFit.cover),
          ),
        ),
      ),
    );
  }

  Widget _buildTextSection(BuildContext context, bool isWide) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        mainAxisAlignment: isWide ? MainAxisAlignment.center : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  color: AppColors.darkBackground,
                  fontSize: isWide ? 48 : 34,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                  height: 1.2,
                ),
          ),
          const SizedBox(height: 16),
          Text(
            description,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppColors.darkTextSecondary,
                  fontSize: isWide ? 22 : 18,
                  letterSpacing: 1,
                  height: 1.2,
                ),
          ),
        ],
      ),
    );
  }
}
