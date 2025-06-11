import 'package:flutter/material.dart';
import '../../core/theme/app_sizes.dart';

class CustomTextFormField extends StatelessWidget {
  final String hintText;
  final String labelText;
  final IconData? prefixIcon;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool obscureText;
  final FormFieldValidator<String>? validator;

  const CustomTextFormField({
    super.key,
    required this.hintText,
    required this.labelText,
    this.prefixIcon,
    this.controller,
    this.keyboardType,
    this.obscureText = false,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      validator: validator,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
        labelStyle: const TextStyle(color: Colors.black),
        floatingLabelStyle: const TextStyle(color: Colors.black),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black, width: 1.5),
          borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black, width: 1.5),
          borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
        ),
      ),

    );
  }
}
