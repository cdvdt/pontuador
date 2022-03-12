import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pontuador/src/Model/TimeTag.dart';

class TimeTagView extends StatelessWidget {
  final TimeTag _timeTag;

  const TimeTagView(TimeTag timeTag, {Key? key}) : _timeTag = timeTag, super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(DateFormat("dd/MM/yyyy HH:mm:ss").format(_timeTag.time)),
      subtitle: _timeTag.description != "" ? Text(_timeTag.description) : null,
      trailing: Row(children: const [
        IconButton(onPressed: null, icon: Icon(Icons.edit)),
        IconButton(onPressed: null, icon: Icon(Icons.delete))
      ], mainAxisSize: MainAxisSize.min),
    );
  }
}
