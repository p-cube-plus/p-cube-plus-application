extension DateTimeExtension on DateTime {
  DateTime get firstDate => DateTime(year, month, 1);
  int get firstDateWeekday => firstDate.weekday % DateTime.daysPerWeek;

  DateTime get lastDate =>
      DateTime(year, month + 1, 1).subtract(const Duration(days: 1));
  int get lastDateWeekday => lastDate.weekday % DateTime.daysPerWeek;

  int get numberOfWeeks =>
      (firstDate.weekday + lastDate.day - 1) ~/ DateTime.daysPerWeek + 1;

  bool isBetweenDates(DateTime? startDate, DateTime? endDate) {
    if (startDate == null || endDate == null) return false;
    return isAfter(startDate) && isBefore(endDate) ||
        isAtSameMomentAs(startDate) ||
        isAtSameMomentAs(endDate);
  }
}
