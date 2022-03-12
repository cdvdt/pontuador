class TimeTag {
  DateTime _time;
  DateTime get time => _time;

  String description;

  TimeTag(): _time = DateTime.now(), description = "";
}