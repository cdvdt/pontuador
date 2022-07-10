import 'package:shared_preferences/shared_preferences.dart';

class Settings {
  bool useSystemTheme = true;
  bool useDarkMode = false;

  static final Settings _instance = Settings._internal();

  Settings._internal();

  factory Settings() {
    return _instance;
  }

  Future<void> update() async {
    final prefs = await SharedPreferences.getInstance();
    await Future.wait([
      prefs.setBool('useSystemTheme', useSystemTheme),
      prefs.setBool('useSystemTheme', useSystemTheme)
    ]);
  }

  Future<Settings> read() async {
    final prefs = await SharedPreferences.getInstance();
    useSystemTheme = prefs.getBool('useSystemTheme') ?? true;
    useDarkMode = prefs.getBool('useDarkMode') ?? false;

    return this;
  }
}
