import 'package:flutter/material.dart';

import '../../core/theme/app_sizes.dart';

class CustomButtonIcon extends StatelessWidget {
  final String text;
  final String iconPath;
  final VoidCallback onPressed;

  const CustomButtonIcon({
    super.key,
    required this.text,
    required this.iconPath,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Image.asset(
        iconPath,
      ),
      label: Text(text),
      style: ElevatedButton.styleFrom(
        minimumSize: Size(AppSizes.buttonWidth, AppSizes.buttonHeight),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusDefault),
        ),
      ),
    );
  }
}
