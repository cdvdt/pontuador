class DateTimeController{
  static DateTime toStartOfDay(DateTime date) =>
      DateTime(date.year, date.month, date.day);

  static DateTime toEndOfDay(DateTime date) =>
      DateTime(date.year, date.month, date.day + 1)
          .subtract(const Duration(milliseconds: 1));
}