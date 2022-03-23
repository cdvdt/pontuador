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

  List<TimeStamp> getTimeTags() => timeStampBox.values.toList();

  void addTimeTag(TimeStamp timeTag) => timeStampBox.add(timeTag);

  void removeTimeTag(TimeStamp timeTag) => timeStampBox.delete(timeTag.key);
}