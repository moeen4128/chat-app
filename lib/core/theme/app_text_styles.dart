import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles {
  static const TextStyle headline1 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w500,
    color: AppColors.text,
  );

  static const TextStyle headline2 = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    color: AppColors.text,
  );

  static const TextStyle body = TextStyle(
    fontSize: 16,
    color: AppColors.text,
  );

  static const TextStyle buttonText = TextStyle(
    fontSize: 12,
    color: AppColors.secondary_dark,
  );
  static const TextStyle testButton = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w700,
    color: AppColors.primary_main,
  );

  static const TextStyle label = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: AppColors.text,
  );

  static const TextStyle caption = TextStyle(
    fontSize: 13,
    color: AppColors.subtitle,
  );

  static const TextStyle button = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: Colors.white,
  );
}
