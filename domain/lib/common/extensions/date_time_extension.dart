extension DateTimeExtension on DateTime {
  DateTime get firstDate => DateTime(year, month, 1);
  DateTime get lastDate => DateTime(year, month + 1, 0);
  int get weekDayIndex => weekday % DateTime.daysPerWeek;

  int get numberOfWeeks =>
      (firstDate.weekDayIndex + lastDate.day - 1) ~/ DateTime.daysPerWeek + 1;

  bool isBetweenDates(DateTime? startDate, DateTime? endDate) {
    if (startDate == null || endDate == null) return false;
    return isAfter(startDate) && isBefore(endDate) ||
        isAtSameMomentAs(startDate);
  }

  bool isSameDay(DateTime dateTime) {
    return year == dateTime.year &&
        month == dateTime.month &&
        day == dateTime.day;
  }

  bool isSameMonth(DateTime dateTime) {
    return year == dateTime.year && month == dateTime.month;
  }
}
