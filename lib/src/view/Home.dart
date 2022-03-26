import 'package:flutter/material.dart';
import 'package:pontuador/src/view/Timer.dart';

import '../model/CustomTheme.dart';
import 'TimeStamp/Pontuador.dart';

class Home extends StatefulWidget {
  const Home({Key? key, required this.title, required this.darkTheme, required this.lightTheme, required this.onThemeChange}) : super(key: key);

  final String title;
  final CustomTheme darkTheme;
  final CustomTheme lightTheme;
  final dynamic onThemeChange;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool? _usingDarkTheme;
  bool get usingDarkTheme {
    _usingDarkTheme ??= true; //TODO: Implement load and save for this.
    return _usingDarkTheme!;
  }
  set usingDarkTheme(bool value) {
    _usingDarkTheme = value;
  }
  CustomTheme get currentTheme => usingDarkTheme? widget.darkTheme: widget.lightTheme;

    @override
    Widget build(BuildContext context) {
      return Scaffold(
          appBar: AppBar(title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.title),
              IconButton(onPressed: onThemeChange, icon: Icon(currentTheme.icon))
            ],
          ),),
          bottomNavigationBar: tabBar(),
          body: TabBarView(
            children: [
              PontuadorView(),
              TimersView()
            ],
          ) // This trailing comma makes auto-formatting nicer for build methods.
      );
    }

    PreferredSizeWidget? tabBar() {
      return const TabBar(
          tabs: [
            Tab(
              icon: Icon(Icons.control_point),
            ),
            Tab(
              icon: Icon(Icons.timer),
            )
          ]
      );
    }

    void onThemeChange(){
      setState(() {
        usingDarkTheme = !usingDarkTheme;
        widget.onThemeChange(currentTheme);
      });
    }
  }

