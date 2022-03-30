import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pontuador/src/model/TimeStamp.dart';

class TimeStampEdit extends StatefulWidget {
  final TimeStamp _timeStamp;
  String _description;
  DateTime _date;
  DateTime _time;
  final void Function(TimeStamp timeStamp) _onApplyChanges;

  TimeStampEdit(timeStamp, void Function(TimeStamp timeStamp) onApplyChanges,
      {Key? key})
      : _timeStamp = timeStamp,
        _description = timeStamp.description,
        _date = timeStamp.value,
        _time = timeStamp.value,
        _onApplyChanges = onApplyChanges,
        super(key: key);

  @override
  State<TimeStampEdit> createState() => _TimeStampEditState();
}

class _TimeStampEditState extends State<TimeStampEdit> {
  final TextEditingController controller = TextEditingController();
  
  @override
  void initState() {
    super.initState();

    controller.text = widget._description;
    controller.addListener(() => setState(()  => widget._description = controller.text));
  }

  TimeOfDay _timeAsTimeOfDay () => TimeOfDay.fromDateTime(widget._time);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit TimeStamp'), actions: [
        IconButton(
            onPressed: () {
              var timeStamp = widget._timeStamp;
              timeStamp.description = controller.text;
              var time = widget._time;
              if (!time.isAtSameMomentAs(timeStamp.value))
                timeStamp.time = _timeAsTimeOfDay();
              timeStamp.date = widget._date;
              widget._onApplyChanges(widget._timeStamp);
              Navigator.pop(context);
            },
            icon: const Icon(Icons.check)),
      ]),
      body: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: const Text('Description'),
              subtitle: TextFormField(
                controller: controller,
              ),
            ),
            ListTile(
              title: const Text('Date'),
              subtitle: TextButton(
                  onPressed: () async {
                    final DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: widget._date,
                        initialDatePickerMode: DatePickerMode.day,
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2100));
                    if (picked != null) {
                      setState(() => widget._date = picked);
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(DateFormat("dd/MM/yyyy")
                          .format(widget._date)),
                      Icon(Icons.calendar_today),
                    ],
                  )),
            ),
            ListTile(
              title: const Text('Time'),
              subtitle: TextButton(
                  onPressed: () async {
                    final TimeOfDay? picked = await showTimePicker(
                        context: context,
                        initialTime: _timeAsTimeOfDay());
                    if (picked != null) {
                      setState(() {
                        widget._time = DateTime(0,0,0, picked.hour, picked.minute);
                      });
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(_timeAsTimeOfDay().format(context)),
                      Icon(Icons.timer),
                    ],
                  )),
            )
          ]),
    );
  }
}
