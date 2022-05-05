import 'package:pontuador/src/model/CustomTheme.dart';

class ThemeControllerNotInitializedException implements Exception {}

class ThemeController {
  static final ThemeController _instance = ThemeController._internal();

  ThemeController._internal();

  factory ThemeController() {
    return _instance;
  }

  void Function(CustomTheme theme)? _onChangeTheme;

  //TODO: Implement load and save for this.
  bool usingDarkTheme = true;

  static void init(void Function(CustomTheme theme) onChangeTheme,
      [bool useDarkTheme = true]) {
    var themeController = ThemeController();
    themeController._onChangeTheme = onChangeTheme;
    themeController.usingDarkTheme = useDarkTheme;
  }

  void switchTheme() {
    if (_onChangeTheme != null) {
      usingDarkTheme = !usingDarkTheme;
      _onChangeTheme!(currentTheme);
    } else {
      throw ThemeControllerNotInitializedException();
    }
  }

  CustomTheme get currentTheme {
    return usingDarkTheme ? CustomTheme.darkTheme : CustomTheme.lightTheme;
  }
}
