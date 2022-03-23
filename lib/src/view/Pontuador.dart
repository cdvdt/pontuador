import 'package:flutter/material.dart';
import 'package:pontuador/src/controller/TimeStampController.dart';
import 'package:pontuador/src/model/TimeStamp.dart';
import 'package:pontuador/src/view/TimeTagView.dart';

class PontuadorView extends StatefulWidget {
  PontuadorView();

  @override
  State<PontuadorView> createState() => _PontuadorViewState();
}

class _PontuadorViewState extends State<PontuadorView>
    with AutomaticKeepAliveClientMixin<PontuadorView> {
  @override
  bool get wantKeepAlive => true;

  List<TimeStamp> timeTags = [];

  void updateTags() => timeTags = TimeStampController().getTimeTags();

  @override
  void initState() {
    super.initState();
    updateTags();
  }

  void _addTimeTag() {
    final newTag = TimeStamp.newStamp();
    TimeStampController().addTimeTag(newTag);
    setState(() => updateTags());
  }

  void _removeTimeTag(TimeStamp timeTag) {
    TimeStampController().removeTimeTag(timeTag);
    setState(() => updateTags());
  }

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
                (context, index) =>
                    TimeTagView(timeTags[index], _removeTimeTag),
                childCount: timeTags.length)),
      ])),
    );
  }
}
