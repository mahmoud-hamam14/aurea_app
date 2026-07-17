import 'package:flutter/material.dart';
import '../../../../core/utils/app_colors.dart';

// ignore: must_be_immutable
class LogoutButton extends StatelessWidget {
  LogoutButton({super.key, required this.onPressed});
  void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        minimumSize: Size(200, 48),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      onPressed: onPressed,
      icon: Icon(Icons.logout, color: AppColors.error),
      label: Text(
        "Logout",
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
          color: AppColors.error,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
