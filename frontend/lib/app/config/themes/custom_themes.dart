import 'package:flutter/material.dart';
import 'package:frontend/app/core/constants/app_colors.dart';
import 'package:frontend/app/core/constants/app_fonts.dart';
import 'package:frontend/app/core/constants/app_sizes.dart';

class CustomThemes {
  /// Light Theme
  ThemeData light() {
    return ThemeData(
      fontFamily: AppFonts.cairo,
      canvasColor: AppColors.secondary,
      scaffoldBackgroundColor: AppColors.background,
      dividerColor: AppColors.secondary,
      primaryColor: AppColors.primary,
      textTheme: TextTheme(
        headline1: TextStyle(
          fontSize: AppSize.s7,
          color: AppColors.headText,
          fontWeight: FontWeight.w700,
        ),
        headline2: TextStyle(
          fontSize: AppSize.s6,
          color: AppColors.headText,
          fontWeight: FontWeight.w400,
        ),
        headline6: TextStyle(
          fontSize: AppSize.s5,
          color: AppColors.headText,
        ),
        subtitle1: TextStyle(
          fontSize: AppSize.s3,
          color: AppColors.headText,
        ),
      ),
    );
  }

  /// Dark Theme
  ThemeData dark() {
    return ThemeData(
      colorScheme: const ColorScheme.dark(),
      fontFamily: AppFonts.cairo,
      canvasColor: AppColors.secondary,
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.background,
      dividerColor: AppColors.secondary,
      primaryColorDark: AppColors.primary,
      hintColor: Colors.black45,
      secondaryHeaderColor: AppColors.headText,
      primaryIconTheme: const IconThemeData(color: Colors.white),
      tabBarTheme: TabBarTheme(
        labelColor: Colors.white,
        labelStyle: TextStyle(
          color: Colors.white,
          fontSize: AppSize.s4,
          fontWeight: FontWeight.w600,
        ),
      ),
      // input decoration
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: TextStyle(
          color: Colors.white,
          fontSize: AppSize.s4,
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        hintStyle: TextStyle(
          color: Colors.white38,
          fontSize: AppSize.s4,
        ),
      ),
      // Icon Style
      iconTheme: IconThemeData(
        color: Colors.white,
        size: AppSize.s12,
      ),
      // Text Style
      textTheme: TextTheme(
        headline1: TextStyle(
          fontSize: AppSize.s7,
          color: AppColors.headText,
          fontWeight: FontWeight.w700,
        ),
        headline2: TextStyle(
          fontSize: AppSize.s6,
          color: AppColors.headText,
          fontWeight: FontWeight.w400,
        ),
        headline6: TextStyle(
          fontSize: AppSize.s5,
          color: AppColors.headText,
        ),
        subtitle1: TextStyle(
          fontSize: AppSize.s3,
          color: AppColors.headText,
        ),
      ),
    );
  }
}
