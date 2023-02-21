import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pontuador/src/model/TimeStamp.dart';

class TimeStampController {
  static final TimeStampController _instance = TimeStampController._internal();

  TimeStampController._internal();

  late final Box<TimeStamp> timeStampBox;

  factory TimeStampController() {
    return _instance;
  }

  static Future<void> init() async {
    Hive.registerAdapter(TimeStampAdapter());
    _instance.timeStampBox = await Hive.openBox<TimeStamp>('timeStamp');
  }

  List<TimeStamp> getTimeStamps() => timeStampBox.values.toList();

  TimeStamp? get oldest {
    var items = timeStampBox.values;
    if (items.isNotEmpty) {
      var list = items.toList()..sort((a, b) => a.compareTo(b));
      return list.first;
    } else null;
  }

  TimeStamp? get newest {
    var items = timeStampBox.values;
    if (items.isNotEmpty) {
      var list = items.toList()..sort((a, b) => a.compareTo(b));
      return list.last;
    } else null;
  }

  void addTimeStamp(TimeStamp timeStamp) => timeStampBox.add(timeStamp);

  void removeTimeStamp(TimeStamp timeStamp) =>
      timeStampBox.delete(timeStamp.key);

  ValueListenable<Box<TimeStamp>> getTimeStampListenable() =>
      timeStampBox.listenable();

  void updateTimeStamp(TimeStamp timeStamp) =>
      timeStampBox.put(timeStamp.key, timeStamp);

  void removeByPeriod(DateTime start, DateTime end) {
    var items = timeStampBox.values;
    if (items.isNotEmpty) {
      var list = items.where((value) {
        var date = value.value;
        return date.isAfter(start) && date.isBefore(end);
      });
      timeStampBox.deleteAll(list.map((e) => e.key));
    }
  }
}
