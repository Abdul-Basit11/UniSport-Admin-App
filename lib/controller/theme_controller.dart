import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../services/theme_services.dart';

class ThemeController extends GetxController {
  ThemeService _themeService = ThemeService();

  ThemeMode get theme => _themeService.getThemeMode();

  void switchTheme() {
    _themeService.switchTheme();
    update();
  }
}
