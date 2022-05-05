import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pontuador/src/controller/TimeStampController.dart';
import 'package:pontuador/src/model/TimeStamp.dart';
import 'package:pontuador/src/view/TimeStamp/TimeStampEdit.dart';
import 'package:pontuador/src/view/TimeStamp/TimeStampView.dart';

class PontuadorView extends StatefulWidget {
  const PontuadorView({Key? key}) : super(key: key);

  @override
  State<PontuadorView> createState() => _PontuadorViewState();
}

class _PontuadorViewState extends State<PontuadorView>
    with AutomaticKeepAliveClientMixin<PontuadorView> {
  @override
  bool get wantKeepAlive => true;

  //List<TimeStamp> timeTags = [];

  //void updateTags() => timeTags = TimeStampController().getTimeTags();

  @override
  void initState() {
    super.initState();
    //updateTags();
  }

  void _addTimeTag() {
    final newStamp = TimeStamp.newStamp();
    TimeStampController().addTimeStamp(newStamp);
    //setState(() => updateTags());
  }

  void _removeTimeTag(TimeStamp timeStamp) {
    TimeStampController().removeTimeStamp(timeStamp);
    //setState(() => updateTags());
  }

  void _editTimeTag(TimeStamp timeStamp) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TimeStampEdit(
              timeStamp,
              (TimeStamp timeStamp) =>
                  TimeStampController().updateTimeStamp(timeStamp)),
        ));
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
      body: ValueListenableBuilder<Box<TimeStamp>>(
          valueListenable: TimeStampController().getTimeStampListenable(),
          builder: (context, box, widget) {
            var timeTags = box.values.toList();
            timeTags.sort((a, b) => a.compareTo(b));
            return Center(
                child: CustomScrollView(slivers: [
              SliverList(
                  delegate: SliverChildBuilderDelegate(
                      (context, index) => TimeStampView(
                          //box.values.toList()[index],
                          timeTags[index],
                          _editTimeTag,
                          _removeTimeTag),
                      childCount: timeTags.length)),
            ]));
          }),
    );
  }
}
