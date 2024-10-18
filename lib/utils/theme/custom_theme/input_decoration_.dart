import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../const/colors.dart';
import '../../const/sizes.dart';

class AppInputDecoration {
  /// light theme
  static InputDecorationTheme textFieldDecoration = InputDecorationTheme(
    alignLabelWithHint: true,
    hintStyle: GoogleFonts.poppins(
      fontSize: 14,
      fontWeight: FontWeight.w400,
    ),
    errorMaxLines: 2,
    errorStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w300, color: AppColors.kErrorColor),
    isDense: true,
    filled: true,
    iconColor: AppColors.kPrimary,
    // fillColor: AppColors.kSecondary.withOpacity(0.4),
    fillColor: AppColors.kwhite.withOpacity(0.4),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSizes.md),
      borderSide: BorderSide(color: AppColors.kGrey),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSizes.md),
      borderSide: BorderSide(color: AppColors.kPrimary, width: 1.5),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSizes.md),
      borderSide: BorderSide(color: AppColors.kGrey),
    ),
  );

  /// dark theme
  static InputDecorationTheme darktextFieldDecoration = InputDecorationTheme(
    alignLabelWithHint: true,
    hintStyle: GoogleFonts.poppins(
      fontSize: 14,
      fontWeight: FontWeight.w400,
    ),
    errorMaxLines: 2,
    errorStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w300, color: AppColors.kErrorColor),
    isDense: true,
    filled: true,
    fillColor: AppColors.kwhite.withOpacity(0.4),
    iconColor: AppColors.kPrimary,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSizes.md),
      borderSide: BorderSide(color: AppColors.kwhite),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSizes.md),
      borderSide: BorderSide(color: AppColors.kLightGrey, width: 1.5),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSizes.md),
      borderSide: BorderSide(color: AppColors.kLightGrey),
    ),
  );
}
