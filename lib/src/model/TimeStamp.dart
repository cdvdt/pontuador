import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'TimeStamp.g.dart';

@HiveType(typeId: 1)
class TimeStamp extends HiveObject {
  //int id = 0;

  TimeStamp()
      : _time = DateTime.now(),
        description = "";

  @HiveField(0)
  DateTime _time;

  DateTime get value => _time;

  set date(DateTime value) {
    _time = DateTime(value.year, value.month, value.day, _time.hour,
        _time.minute, _time.second);
  }

  set time(TimeOfDay value) {
    _time = DateTime(_time.year, _time.month, _time.day, value.hour,
        value.minute);
  }

  @HiveField(1)
  String description;

  //TimeTag(): _time = DateTime.now(), description = "";
  TimeStamp.newStamp()
      : _time = DateTime.now(),
        description = "";

  int compareTo(TimeStamp b) {
    return value.compareTo(b.value);
  }
}
