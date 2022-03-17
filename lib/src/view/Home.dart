import 'package:flutter/material.dart';
import 'package:pontuador/src/Model/TimeTag.dart';
import 'package:pontuador/src/view/TimeTagView.dart';

class Home extends StatefulWidget {
  const Home({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<TimeTag> timeTags = [];

  void _addTimeTag() => setState(() => timeTags.add(TimeTag()));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
          /*child: ListView(
          children: timeTags.map((timeTag) => TimeTagView(timeTag)).toList()
        ),*/
          child: CustomScrollView(slivers: [
        SliverList(
            delegate: SliverChildBuilderDelegate(
                (context, index) => TimeTagView(timeTags[index]),
                childCount: timeTags.length)),
      ])),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTimeTag,
        tooltip: 'Adicionar pontuação',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
