import 'package:flutter/material.dart';
import 'package:pontuador/src/model/Settings.dart';

class ThemeControllerNotInitializedException implements Exception {}

class ThemeController {
  static final ThemeController _instance = ThemeController._internal();

  ThemeController._internal();

  factory ThemeController() {
    return _instance;
  }

  void Function(ThemeMode themeMode)? _onChangeThemeMode;

  static void init(void Function(ThemeMode themeMode) onChangeThemeMode,
      [bool useDarkTheme = true]) {
    var themeController = ThemeController();
    themeController._onChangeThemeMode = onChangeThemeMode;
  }

  void updateThemeMode(Settings settings) {
    if (_onChangeThemeMode != null) _onChangeThemeMode!(getThemeMode(settings));
  }

  ThemeMode getThemeMode(Settings settings) => settings.useSystemTheme
      ? ThemeMode.system
      : settings.useDarkMode
          ? ThemeMode.dark
          : ThemeMode.light;
}
