import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pontuador/src/model/TimeStamp.dart';

class TimeTagView extends StatelessWidget {
  final TimeStamp _timeStamp;
  final void Function(TimeStamp timeTag) _onEdit;
  final void Function(TimeStamp timeTag) _onDelete;

  const TimeTagView(
      TimeStamp timeStamp,
      final void Function(TimeStamp timeTag) onEdit,
      void Function(TimeStamp timeTag) onDelete,
      {Key? key})
      : _timeStamp = timeStamp,
        _onEdit = onEdit,
        _onDelete = onDelete,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(DateFormat("dd/MM/yyyy HH:mm:ss").format(_timeStamp.value)),
      subtitle:
          _timeStamp.description != "" ? Text(_timeStamp.description) : null,
      trailing: Row(children: [
        IconButton(
            onPressed: () => _onEdit(_timeStamp), icon: const Icon(Icons.edit)),
        IconButton(
            onPressed: () => _onDelete(_timeStamp),
            icon: const Icon(Icons.delete))
      ], mainAxisSize: MainAxisSize.min),
    );
  }
}
