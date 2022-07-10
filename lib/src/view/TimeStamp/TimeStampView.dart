import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pontuador/src/model/TimeStamp.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:pontuador/src/view/CustomDialog.dart';

class TimeStampView extends StatelessWidget {
  final TimeStamp _timeStamp;
  final void Function(TimeStamp timeStamp) _onEdit;
  final void Function(TimeStamp timeStamp) _onDelete;
  static const _editIcon = Icons.edit;
  static const _deleteIcon = Icons.delete;

  const TimeStampView(
      TimeStamp timeStamp,
      final void Function(TimeStamp timeTag) onEdit,
      void Function(TimeStamp timeTag) onDelete,
      {Key? key})
      : _timeStamp = timeStamp,
        _onEdit = onEdit,
        _onDelete = onDelete,
        super(key: key);

  _deleteItem(BuildContext context) => CustomDialog.question(context,
          title: "Confirm deletion",
          message: "Are you sure?", handler: (value) {
        if (value) _onDelete(_timeStamp);
      });

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: ValueKey<TimeStamp>(_timeStamp),
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) => _onEdit(_timeStamp),
            icon: _editIcon,
          )
        ],
      ),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: _deleteItem,
            icon: _deleteIcon,
            backgroundColor: Theme.of(context).errorColor,
          )
        ],
      ),
      child: ListTile(
        title: Text(DateFormat("dd/MM/yyyy HH:mm:ss").format(_timeStamp.value)),
        subtitle:
            _timeStamp.description != "" ? Text(_timeStamp.description) : null,
        trailing: Row(mainAxisSize: MainAxisSize.min, children: [
          IconButton(
              onPressed: () => _onEdit(_timeStamp),
              icon: const Icon(_editIcon)),
          IconButton(
              onPressed: () => _deleteItem(context),
              icon: const Icon(_deleteIcon))
        ]),
      ),
    );
  }
}
