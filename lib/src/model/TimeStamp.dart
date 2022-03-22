import 'package:objectbox/objectbox.dart';

@Entity()
class TimeStamp {
  int id = 0;

  TimeStamp(this.id, time, this.description): _time = time;

  DateTime _time;
  DateTime get time => _time;

  String description;

  //TimeTag(): _time = DateTime.now(), description = "";
  TimeStamp.newStamp(): _time = DateTime.now(), description = "";
}