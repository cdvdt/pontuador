import 'package:flutter/material.dart';
import 'package:pontuador/src/controller/HiveController.dart';
import 'package:pontuador/src/controller/ThemeController.dart';
import 'package:pontuador/src/model/CustomTheme.dart';
import 'package:pontuador/src/view/Home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await HiveController.init();

  runApp(const PontuadorApp());
}

class PontuadorApp extends StatefulWidget {
  const PontuadorApp({Key? key}) : super(key: key);

  @override
  State<PontuadorApp> createState() => _PontuadorAppState();
}

class _PontuadorAppState extends State<PontuadorApp> {
  CustomTheme currentTheme = CustomTheme.darkTheme;

  _PontuadorAppState() {
    ThemeController.init(setTheme);
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: currentTheme.theme,
      home: const DefaultTabController(
          length: 2,
          child: Home(
              title: 'Pontuador',
              )),
    );
  }

  void setTheme(CustomTheme theme) {
    setState(() {
      currentTheme = theme;
    });
  }
}
