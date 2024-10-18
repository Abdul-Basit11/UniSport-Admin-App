import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../const/colors.dart';

class AppTextTheme {
  static TextTheme lighttextTheme = TextTheme(
    headlineLarge: GoogleFonts.poppins(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: AppColors.kblack,
    ),
    headlineMedium:  GoogleFonts.poppins(
      fontSize: 23,
      fontWeight: FontWeight.w600,
      color: AppColors.kblack,

    ),
    headlineSmall:  GoogleFonts.poppins(
      fontSize: 18,
      color: AppColors.kblack,
      fontWeight: FontWeight.w600,
    ),
    titleLarge: GoogleFonts.poppins(
      fontSize: 18,
      color: AppColors.kblack,
      fontWeight: FontWeight.w600,
    ),
    titleMedium: GoogleFonts.poppins(
      fontSize: 18,
      color: AppColors.kblack,
      fontWeight: FontWeight.w500,
    ),
    titleSmall: GoogleFonts.poppins(
      fontSize: 18,
      color: AppColors.kblack,
      fontWeight: FontWeight.w400,
    ),
    bodyLarge: GoogleFonts.poppins(
      fontSize: 14,
      color: AppColors.kblack,
      fontWeight: FontWeight.w500,
    ),
    bodyMedium: GoogleFonts.poppins(
      fontSize: 14,
      color: AppColors.kblack,
      fontWeight: FontWeight.normal,
    ),
    bodySmall: GoogleFonts.poppins(
      fontSize: 14,
      color: AppColors.kblack,
      fontWeight: FontWeight.w500,
    ),
    labelLarge: GoogleFonts.poppins(
      fontSize: 12,
      color: AppColors.kblack,
      fontWeight: FontWeight.normal,
    ),
    labelMedium: GoogleFonts.poppins(
      fontSize: 12,
      color: AppColors.kblack,
      fontWeight: FontWeight.normal,
    ),
  );
  static TextTheme darktextTheme = TextTheme(
    headlineLarge: GoogleFonts.poppins(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: AppColors.kwhite,
    ),
    headlineMedium:  GoogleFonts.poppins(
      fontSize: 23,
      fontWeight: FontWeight.w600,
      color: AppColors.kwhite,


    ),
    headlineSmall:  GoogleFonts.poppins(
      fontSize: 18,
      color: AppColors.kwhite,

      fontWeight: FontWeight.w600,
    ),
    titleLarge: GoogleFonts.poppins(
      fontSize: 18,
      color: AppColors.kwhite,

      fontWeight: FontWeight.w600,
    ),
    titleMedium: GoogleFonts.poppins(
      fontSize: 18,
      color: AppColors.kwhite,

      fontWeight: FontWeight.w500,
    ),
    titleSmall: GoogleFonts.poppins(
      fontSize: 18,
      color: AppColors.kwhite,

      fontWeight: FontWeight.w400,
    ),
    bodyLarge: GoogleFonts.poppins(
      fontSize: 14,
      color: AppColors.kwhite,

      fontWeight: FontWeight.w500,
    ),
    bodyMedium: GoogleFonts.poppins(
      fontSize: 14,
      color: AppColors.kwhite,

      fontWeight: FontWeight.normal,
    ),
    bodySmall: GoogleFonts.poppins(
      fontSize: 14,
      color: AppColors.kwhite,

      fontWeight: FontWeight.w500,
    ),
    labelLarge: GoogleFonts.poppins(
      fontSize: 12,
      color: AppColors.kwhite,

      fontWeight: FontWeight.normal,
    ),
    labelMedium: GoogleFonts.poppins(
      fontSize: 12,
      color: AppColors.kwhite,

      fontWeight: FontWeight.normal,
    ),
  );
}
