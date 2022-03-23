import 'package:flutter/material.dart';
import 'package:pontuador/src/controller/HiveController.dart';
import 'package:pontuador/src/model/CustomTheme.dart';
import 'package:pontuador/src/view/Home.dart';

//late ObjectBox objectbox;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await HiveController.init();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  static const darkThemeIcon = Icons.nightlight_round;
  static const lightThemeIcon = Icons.wb_sunny;

  static const tabTopRadius = Radius.circular(15);
  static const appBarBottomRadius = Radius.circular(5);
  static const tabSelectedDarkColor = Colors.black12;
  static const appBarDarkColor = Colors.transparent;

  static CustomTheme darkTheme = CustomTheme(theme: ThemeData(
    colorScheme: const ColorScheme.dark(),
    tabBarTheme: const TabBarTheme(
      indicator: ShapeDecoration(color: tabSelectedDarkColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(
              topRight: tabTopRadius, topLeft: tabTopRadius))),

    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Colors.red,
        elevation: 4,
        foregroundColor: Colors.white),
    appBarTheme: const AppBarTheme(
        backgroundColor: appBarDarkColor,
        shadowColor: appBarDarkColor,
        titleTextStyle: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 25, color: Colors.white),
        centerTitle: false
    ),

  ), icon: darkThemeIcon);

  static CustomTheme lightTheme = CustomTheme(theme: ThemeData(
    colorScheme: const ColorScheme.light(),
    tabBarTheme: const TabBarTheme(
      labelColor: Colors.black,
      indicator: ShapeDecoration(color: tabSelectedDarkColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(
              topRight: tabTopRadius, topLeft: tabTopRadius))),

    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Colors.red,
        elevation: 4,
        foregroundColor: Colors.white),
    appBarTheme: const AppBarTheme(
        backgroundColor: appBarDarkColor,
        shadowColor: appBarDarkColor,
        titleTextStyle: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 25, color: Colors.black),
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: false
    ),

  ), icon: lightThemeIcon);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  CustomTheme currentTheme = MyApp.darkTheme;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: currentTheme.theme,
      home: DefaultTabController(
          length: 2, child: Home(title: 'Pontuador', darkTheme: MyApp.darkTheme, lightTheme: MyApp.lightTheme, onThemeChange: setTheme)),
    );
  }

  void setTheme(CustomTheme theme){
    setState(() {
      currentTheme = theme;
    });
  }
}
