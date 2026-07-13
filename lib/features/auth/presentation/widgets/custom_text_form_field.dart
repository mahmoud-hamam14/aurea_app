import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.labelText,
    this.controller,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.onChanged,
  });

  final String labelText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;

  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onChanged: onChanged,
      validator: validator,
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: prefixIcon != null ? Icon(prefixIcon, size: 20) : null,
        suffixIcon: suffixIcon != null ? Icon(suffixIcon, size: 20) : null,
        labelText: labelText,
        labelStyle: Theme.of(context).textTheme.bodyMedium,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).focusColor, width: 1),
          borderRadius: BorderRadius.circular(16),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}
