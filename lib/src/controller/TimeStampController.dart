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

  void addTimeStamp(TimeStamp timeStamp) => timeStampBox.add(timeStamp);

  void removeTimeStamp(TimeStamp timeStamp) => timeStampBox.delete(timeStamp.key);

  ValueListenable<Box<TimeStamp>> getTimeStampListenable() => timeStampBox.listenable();

  void updateTimeStamp(TimeStamp timeStamp) => timeStampBox.put(timeStamp.key, timeStamp);
}