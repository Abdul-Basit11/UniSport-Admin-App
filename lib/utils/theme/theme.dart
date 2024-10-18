import 'package:flutter/material.dart';

import '../const/colors.dart';
import '../const/sizes.dart';
import 'custom_theme/elevated_button_theme.dart';
import 'custom_theme/input_decoration_.dart';
import 'custom_theme/tabbar_theme.dart';
import 'custom_theme/text_theme.dart';

class AppTheme {
  static ThemeData lightTheme(BuildContext context) {
    return ThemeData(
      appBarTheme: AppBarTheme(
          backgroundColor: Colors.transparent, elevation: 0, iconTheme: IconThemeData(color: AppColors.kPrimary)),
      scaffoldBackgroundColor: Color(0xffE7EDD0),
      brightness: Brightness.light,
      colorSchemeSeed: AppColors.kPrimary,
      useMaterial3: true,
      textTheme: AppTextTheme.lighttextTheme,
      tabBarTheme: AppTabbarTheme.lightTabbar(context),
      inputDecorationTheme: AppInputDecoration.textFieldDecoration,
      elevatedButtonTheme: AppElevatedButton.buttonTheme,
      bottomSheetTheme: BottomSheetThemeData(backgroundColor: Colors.transparent, elevation: 0),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style:
            OutlinedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSizes.md))),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.kPrimary,
        elevation: 5,
        foregroundColor: AppColors.kwhite,
      ),
    );
  }

  static ThemeData darkTheme(BuildContext context) {
    return ThemeData(
      appBarTheme: AppBarTheme(
          backgroundColor: Colors.transparent, elevation: 0, iconTheme: IconThemeData(color: AppColors.kPrimary)),
      scaffoldBackgroundColor: AppColors.kblack,
      brightness: Brightness.dark,
      useMaterial3: true,
      colorSchemeSeed: AppColors.kPrimary,
      textTheme: AppTextTheme.darktextTheme,
      tabBarTheme: AppTabbarTheme.darkTabbar(context),
      inputDecorationTheme: AppInputDecoration.darktextFieldDecoration,
      elevatedButtonTheme: AppElevatedButton.buttonTheme,
      bottomSheetTheme: BottomSheetThemeData(backgroundColor: Colors.transparent, elevation: 0),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style:
            OutlinedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSizes.md))),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.kPrimary,
        elevation: 5,
        foregroundColor: AppColors.kwhite,
      ),
    );
  }
}
