import 'package:flutter/material.dart';
import 'package:pontuador/src/view/Timer.dart';

import 'TimeStamp/Pontuador.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        /*appBar: AppBar(
          title: Text(title),
          actions: [
            /*IconButton(
                onPressed: null,
                icon: Icon(themeController.currentTheme.icon))*/
          ],
        ),*/
        bottomNavigationBar: tabBar(),
        body: const TabBarView(
          children: [PontuadorView(), TimersView()],
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
