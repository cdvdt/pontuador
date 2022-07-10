import 'package:flutter/material.dart';

class TimersView extends StatefulWidget{
  const TimersView();

  @override
  State<TimersView> createState() => _TimersViewState();
}

class _TimersViewState extends State<TimersView> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Icon(Icons.timer),
    );
  }
}