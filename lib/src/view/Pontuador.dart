import 'package:flutter/material.dart';
import 'package:pontuador/src/Model/TimeTag.dart';
import 'package:pontuador/src/view/TimeTagView.dart';

class PontuadorView extends StatefulWidget {
  PontuadorView();

  @override
  State<PontuadorView> createState() => _PontuadorViewState();
}

class _PontuadorViewState extends State<PontuadorView> with AutomaticKeepAliveClientMixin<PontuadorView>{
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
  }
  List<TimeTag> timeTags = [];

  void _addTimeTag() => setState(() => timeTags.add(TimeTag()));

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: _addTimeTag,
        tooltip: 'Adicionar pontuação',
        child: const Icon(Icons.add),
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
    );
  }
}