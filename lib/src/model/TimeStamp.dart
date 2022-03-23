import 'package:hive/hive.dart';

part 'TimeStamp.g.dart';

@HiveType(typeId: 1)
class TimeStamp extends HiveObject {
  //int id = 0;

  TimeStamp(): _time = DateTime.now(), description = "";

  @HiveField(0)
  DateTime _time;
  DateTime get time => _time;

  @HiveField(1)
  String description;

  //TimeTag(): _time = DateTime.now(), description = "";
  TimeStamp.newStamp(): _time = DateTime.now(), description = "";
}