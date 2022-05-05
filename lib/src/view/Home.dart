import 'package:flutter/material.dart';
import 'package:pontuador/src/controller/ThemeController.dart';
import 'package:pontuador/src/view/Timer.dart';

import 'TimeStamp/Pontuador.dart';

class Home extends StatelessWidget {
  const Home({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    var themeController = ThemeController();
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
          actions: [
            IconButton(
                onPressed: () => themeController.switchTheme(),
                icon: Icon(themeController.currentTheme.icon))
          ],
        ),
        bottomNavigationBar: tabBar(),
        body: TabBarView(
          children: [const PontuadorView(), TimersView()],
        ) // This trailing comma makes auto-formatting nicer for build methods.
        );
  }

  PreferredSizeWidget? tabBar() {
    return const TabBar(tabs: [
      Tab(
        icon: Icon(Icons.control_point),
      ),
      Tab(
        icon: Icon(Icons.timer),
      )
    ]);
  }
}
