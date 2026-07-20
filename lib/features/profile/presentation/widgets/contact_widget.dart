import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:nti_ecommerce_team4/core/theme/app_theme.dart';

import '../../../../core/theme/themes.dart';
import '../../../../core/theme/app_colors.dart';

class ContactWidget extends StatelessWidget {
  const ContactWidget({super.key, required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: AppColors.gold, size: 21),

        const Gap(15),

        Text(
          text,
          style: ThemeData().textTheme.bodyLarge?.copyWith(
            fontSize: 15,
            color: Theme.of(context).textTheme.bodyLarge?.color,
          ),
        ),
      ],
    );
  }
}
