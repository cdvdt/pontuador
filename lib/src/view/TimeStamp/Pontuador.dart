import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:pontuador/src/controller/DateTimeController.dart';
import 'package:pontuador/src/controller/TimeStampController.dart';
import 'package:pontuador/src/model/Settings.dart';
import 'package:pontuador/src/model/TimeStamp.dart';
import 'package:pontuador/src/view/SettingsView.dart';
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

  bool _filtered = false;
  DateTime _initialDate = DateTime(2020);
  DateTime _finalDate = DateTime.now();

  DateTime? _lowLimit;
  DateTime get _lowLimitSafe => _lowLimit ?? DateTime(2000);
  DateTime? _highLimit;
  DateTime get _highLimitSafe => _highLimit ?? DateTime(2100);

  @override
  void initState() {
    super.initState();
  }

  void _addTimeStamp() {
    final newStamp = TimeStamp.newStamp();
    TimeStampController().addTimeStamp(newStamp);
    setState(() => _updateLimits());
  }

  void _removeTimeStamp(TimeStamp timeStamp) {
    TimeStampController().removeTimeStamp(timeStamp);
    setState(() => _updateLimits());
  }

  void _editTimeStamp(TimeStamp timeStamp) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TimeStampEdit(timeStamp, (TimeStamp timeStamp) {
            TimeStampController().updateTimeStamp(timeStamp);
            setState(() => _updateLimits());
          }),
        ));
  }

  void _updateLimits() {
    _lowLimit = TimeStampController().oldest?.value;
    _highLimit = TimeStampController().newest?.value;
  }

  Widget _dateSelector(String caption, DateTime currentDate,
      void Function(DateTime selectedDate) onSelected) {
    return Expanded(
        child: ListTile(
      title: Text(caption),
      subtitle: TextButton.icon(
        icon: Icon(Icons.calendar_today),
        clipBehavior: Clip.antiAlias,
        onPressed: () async {
          final DateTime? picked = await showDatePicker(
              context: context,
              initialDate: currentDate,
              initialDatePickerMode: DatePickerMode.day,
              firstDate: _lowLimitSafe,
              lastDate: _highLimitSafe);
          if (picked != null) {
            onSelected(picked);
          }
        },
        label: Text(DateFormat("dd/MM/yyyy").format(currentDate)),
      ),
    ));
  }

  DateTime _max(DateTime a, DateTime b) => a.compareTo(b) < 0 ? b : a;

  DateTime _min(DateTime a, DateTime b) => a.compareTo(b) < 0 ? a : b;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    _updateLimits();
    return Scaffold(
      appBar: AppBar(
        title: Text("Pontuador"),
        actions: [
          IconButton(
              onPressed: _lowLimit == null
                  ? null
                  : () => setState(() => _filtered = !_filtered),
              icon: Icon(Icons.filter_alt)),
          IconButton(
              onPressed: () => Settings().read().then((value) => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SettingsView(value)))),
              icon: Icon(Icons.settings))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTimeStamp,
        tooltip: 'Adicionar pontuação',
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          AnimatedContainer(
            duration: Duration(milliseconds: 150),
            height: _filtered ? 80 : 0,
            child: Flex(
                direction: Axis.horizontal,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _dateSelector(
                      'From date',
                      _max(_initialDate, _lowLimitSafe),
                      (selectedDate) => setState(
                          () => _initialDate = DateTimeController.toStartOfDay(selectedDate))),
                  _dateSelector(
                      'To date',
                      _min(_finalDate, _highLimitSafe),
                      (selectedDate) => setState(
                          () => _finalDate = DateTimeController.toEndOfDay(selectedDate))),
                ]),
          ),
          Expanded(
            child: ValueListenableBuilder<Box<TimeStamp>>(
                valueListenable: TimeStampController().getTimeStampListenable(),
                builder: (context, box, widget) {
                  var timeTags = box.values.toList();
                  if (_filtered) {
                    timeTags.retainWhere((element) {
                      var item = element.value;
                      return item.compareTo(_initialDate) >= 0 &&
                          item.compareTo(_finalDate) <= 0;
                    });
                  }
                  timeTags.sort((a, b) => a.compareTo(b));
                  return Center(
                      child: CustomScrollView(slivers: [
                    SliverList(
                        delegate: SliverChildBuilderDelegate(
                            (context, index) => TimeStampView(
                                //box.values.toList()[index],
                                timeTags[index],
                                _editTimeStamp,
                                _removeTimeStamp),
                            childCount: timeTags.length)),
                  ]));
                }),
          ),
        ],
      ),
    );
  }
}
