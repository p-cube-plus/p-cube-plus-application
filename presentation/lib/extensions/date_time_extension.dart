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

extension DateTimeStringExtension on DateTime {
  String format(String dateFormat) {
    final period = hour < 12 ? "오전" : "오후";
    final hour12 = hour % 12 == 0 ? 12 : hour % 12;

    return dateFormat.replaceFirst("yyyy", "$year")
      ..replaceFirst("MM", "$month".padLeft(2, '0'))
      ..replaceFirst("M", "$month")
      ..replaceFirst("dd", "$day".padLeft(2, '0'))
      ..replaceFirst("d", "$day")
      ..replaceFirst("HH", "$hour".padLeft(2, '0'))
      ..replaceFirst("H", "$hour")
      ..replaceFirst("a", period)
      ..replaceFirst("hh", "$hour12".padLeft(2, '0'))
      ..replaceFirst("h", "$hour12")
      ..replaceFirst("mm", "$minute".padLeft(2, '0'))
      ..replaceFirst("m", "$minute")
      ..replaceFirst("ss", "$second".padLeft(2, '0'))
      ..replaceFirst("s", "$second");
  }
}
