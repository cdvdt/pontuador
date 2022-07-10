import 'package:flutter/material.dart';
import 'package:pontuador/src/controller/HiveController.dart';
import 'package:pontuador/src/controller/ThemeController.dart';
import 'package:pontuador/src/model/CustomTheme.dart';
import 'package:pontuador/src/model/Settings.dart';
import 'package:pontuador/src/view/MainPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await HiveController.init();
  await Settings().read();

  runApp(const PontuadorApp());
}

class PontuadorApp extends StatefulWidget {
  const PontuadorApp({Key? key}) : super(key: key);

  @override
  State<PontuadorApp> createState() => _PontuadorAppState();
}

class _PontuadorAppState extends State<PontuadorApp> {
  ThemeMode _themeMode = ThemeController().getThemeMode(Settings());

  _PontuadorAppState() {
    ThemeController.init((themeMode) => setState(() => _themeMode = themeMode));
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: CustomTheme.lightTheme.theme,
      darkTheme: CustomTheme.darkTheme.theme,
      themeMode: _themeMode,
      home: const DefaultTabController(
          length: 2,
          child: MainPage(
              title: 'Pontuador',
              )),
    );
  }
}
