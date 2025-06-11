import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';
import 'app_sizes.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.background,
    // primaryColor: AppColors.primary,
    textTheme: const TextTheme(
      headlineLarge: AppTextStyles.headline1,
      headlineMedium: AppTextStyles.headline2,
      bodyMedium: AppTextStyles.body,
      bodySmall: AppTextStyles.caption,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary_main,
        foregroundColor: Colors.white,
        textStyle: AppTextStyles.button,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusDefault),
        ),
        minimumSize: const Size.fromHeight(AppSizes.buttonHeight),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(AppSizes.paddingDefault),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizes.radiusDefault),
        borderSide: BorderSide(color: AppColors.border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizes.radiusDefault),
        borderSide: BorderSide(color: AppColors.secondary_main),
      ),
    ),
  );
}
