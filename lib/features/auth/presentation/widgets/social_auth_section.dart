import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:nti_ecommerce_team4/features/auth/presentation/widgets/social_button.dart';

class SocialAuthSection extends StatelessWidget {
  const SocialAuthSection({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // If width is too small, stack buttons vertically
        if (constraints.maxWidth < 300) {
          return Column(
            children: [
              SocialButton(
                onPressed: () {},
                iconPath: 'assets/icons/google.svg',
                title: 'Google',
              ),
              const Gap(12),
              SocialButton(
                onPressed: () {},
                iconPath: 'assets/icons/apple.svg',
                title: 'Apple',
              ),
            ],
          );
        }
        
        return Row(
          children: [
            Expanded(
              child: SocialButton(
                onPressed: () {},
                iconPath: 'assets/icons/google.svg',
                title: 'Google',
              ),
            ),
            const Gap(16),
            Expanded(
              child: SocialButton(
                onPressed: () {},
                iconPath: 'assets/icons/apple.svg',
                title: 'Apple',
              ),
            ),
          ],
        );
      },
    );
  }
}
