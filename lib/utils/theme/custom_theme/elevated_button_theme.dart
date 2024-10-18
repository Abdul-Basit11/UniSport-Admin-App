import 'package:flutter/material.dart';

import '../../const/colors.dart';
import '../../const/sizes.dart';

class AppElevatedButton{
  static ElevatedButtonThemeData buttonTheme=ElevatedButtonThemeData(

    style: ElevatedButton.styleFrom(
      elevation: 4,
      backgroundColor: AppColors.kPrimary,
      foregroundColor: AppColors.kwhite,
      shape: RoundedRectangleBorder(

        borderRadius: BorderRadius.circular(AppSizes.md),
      ),
    ),
  );
}