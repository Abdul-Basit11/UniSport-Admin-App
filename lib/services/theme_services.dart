import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeService {
  final _box = GetStorage();
  final _key = 'isDarkMode';

  /// Load theme from storage and return ThemeMode
  ThemeMode getThemeMode() {
    return _loadThemeFromBox() ? ThemeMode.dark : ThemeMode.light;
  }

  /// Load theme from GetStorage
  bool _loadThemeFromBox() => _box.read(_key) ?? false;

  /// Save theme to GetStorage
  _saveThemeToBox(bool isDarkMode) => _box.write(_key, isDarkMode);

  /// Switch theme and save to GetStorage
  void switchTheme() {
    Get.changeThemeMode(_loadThemeFromBox() ? ThemeMode.light : ThemeMode.dark);
    _saveThemeToBox(!_loadThemeFromBox());
  }
}
