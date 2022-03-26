import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pontuador/src/model/TimeStamp.dart';

class TimeStampEdit extends StatefulWidget {
  final TimeStamp _timeStamp;
  final void Function(TimeStamp timeStamp) _onApplyChanges;

  const TimeStampEdit(
      timeStamp, void Function(TimeStamp timeStamp) onApplyChanges,
      {Key? key})
      : _timeStamp = timeStamp,
        _onApplyChanges = onApplyChanges,
        super(key: key);

  @override
  State<TimeStampEdit> createState() => _TimeStampEditState();
}

class _TimeStampEditState extends State<TimeStampEdit> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController controller =
        TextEditingController(text: widget._timeStamp.description);
    return Scaffold(
      appBar: AppBar(title: const Text('Edit TimeStamp'), actions: [
        IconButton(
            onPressed: () {
              widget._timeStamp.description = controller.text;
              widget._onApplyChanges(widget._timeStamp);
              Navigator.pop(context);
            },
            icon: const Icon(Icons.check)),
      ]),
      body: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Description'),
            TextFormField(
              controller: controller,
            ),
            const Text('Date'),
            TextButton(
                onPressed: () async {
                  final DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: widget._timeStamp.value,
                      initialDatePickerMode: DatePickerMode.day,
                      firstDate: DateTime(2020),
                      lastDate: DateTime(2100));
                  if (picked != null) {
                    setState(() => widget._timeStamp.date = picked);
                  }
                },
                child: Text(
                    DateFormat("dd/MM/yyyy").format(widget._timeStamp.value))),
            const Text('Time'),
            TextButton(
                onPressed: () async {
                  final TimeOfDay? picked = await showTimePicker(
                      context: context,
                      initialTime:
                          TimeOfDay.fromDateTime(widget._timeStamp.value));
                  if (picked != null) {
                    setState(() {
                      widget._timeStamp.time = picked;
                    });
                  }
                },
                child: Text(
                    DateFormat("HH:mm:ss").format(widget._timeStamp.value)))
          ]),
    );
  }
}
