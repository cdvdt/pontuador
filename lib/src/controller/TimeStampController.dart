import 'package:pontuador/src/controller/ObjectBox.dart';
import 'package:pontuador/src/model/TimeStamp.dart';

class TimeStampController {
  static final TimeStampController _instance = TimeStampController._internal();

  TimeStampController._internal();

  final timeStampBox = ObjectBox().store.box<TimeStamp>();

  factory TimeStampController() {
    return _instance;
  }

  List<TimeStamp> getTimeTags() => timeStampBox.getAll();
  
  void addTimeTag(TimeStamp timeTag) => timeStampBox.put(timeTag);

  void removeTimeTag(TimeStamp timeTag) => timeStampBox.remove(timeTag.id);
}