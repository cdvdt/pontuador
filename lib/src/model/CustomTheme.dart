import 'package:flutter/material.dart';

class CustomTheme{
  CustomTheme({ required this.theme, required this.icon });
  ThemeData theme;
  IconData icon;

  static const darkThemeIcon = Icons.nightlight_round;
  static const lightThemeIcon = Icons.wb_sunny;

  static const tabTopRadius = Radius.circular(15);
  static const appBarBottomRadius = Radius.circular(5);
  static const tabSelectedDarkColor = Colors.black12;
  static const appBarDarkColor = Colors.transparent;

  static CustomTheme darkTheme = CustomTheme(
      theme: ThemeData(
        colorScheme: const ColorScheme.dark(),
        tabBarTheme: const TabBarTheme(
          indicator: ShapeDecoration(
              color: tabSelectedDarkColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
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
            centerTitle: false),
      ),
      icon: darkThemeIcon);

  static CustomTheme lightTheme = CustomTheme(
      theme: ThemeData(
        colorScheme: const ColorScheme.light(),
        tabBarTheme: const TabBarTheme(
          labelColor: Colors.black,
          indicator: ShapeDecoration(
              color: tabSelectedDarkColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
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
            centerTitle: false),
      ),
      icon: lightThemeIcon);
}