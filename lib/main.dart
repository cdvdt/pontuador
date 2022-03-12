import 'package:flutter/material.dart';
import 'package:pontuador/src/view/Home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: const ColorScheme.dark(secondary: Colors.red)),
      home: const Home(title: 'Pontuador'),
    );
  }
}
