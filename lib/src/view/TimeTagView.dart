import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pontuador/src/model/TimeStamp.dart';

class TimeTagView extends StatelessWidget {
  final TimeStamp _timeTag;
  final void Function(TimeStamp timeTag) _delete;

  const TimeTagView(TimeStamp timeTag, void Function(TimeStamp timeTag) onDelete,
      {Key? key})
      : _timeTag = timeTag,
        _delete = onDelete,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(DateFormat("dd/MM/yyyy HH:mm:ss").format(_timeTag.time)),
      subtitle: _timeTag.description != "" ? Text(_timeTag.description) : null,
      trailing: Row(children: [
        const IconButton(onPressed: null, icon: Icon(Icons.edit)),
        IconButton(
            onPressed: () => _delete(_timeTag), icon: const Icon(Icons.delete))
      ], mainAxisSize: MainAxisSize.min),
    );
  }
}
