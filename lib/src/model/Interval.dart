import 'package:pontuador/src/model/TimeStamp.dart';

class Range {
  TimeStamp start;
  TimeStamp? end;

  Range(this.start);

  Duration get duration => end != null? end!.value.difference(start.value) : const Duration();
}

class Interval {
  List<Range> ranges = [];

  Duration get accumulated => ranges.fold<Duration>(const Duration(), (previousValue, element) => previousValue + element.duration);
}