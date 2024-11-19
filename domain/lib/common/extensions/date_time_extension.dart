extension DateTimeExtension on DateTime {
  DateTime get firstDate => DateTime(year, month, 1);
  DateTime get lastDate => DateTime(year, month + 1, 0);
  DateTime get previousMonthFirstDate => DateTime(year, month - 1, 1);
  DateTime get nextMonthFirstDate => DateTime(year, month + 1, 1);

  int get weekDayIndex => weekday % DateTime.daysPerWeek;

  int get numberOfWeeks =>
      (firstDate.weekDayIndex + lastDate.day - 1) ~/ DateTime.daysPerWeek + 1;

  /// 범위: [startDate, endDate), 즉 startDate는 포함, endDate는 미포함
  bool isBetweenDates(DateTime startDate, DateTime endDate) {
    return compareTo(startDate) >= 0 && compareTo(endDate) < 0;
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

extension DateTimeStringExtension on DateTime {
  String format(String dateFormat) {
    final period = hour < 12 ? "오전" : "오후";
    final hour12 = hour % 12 == 0 ? 12 : hour % 12;

    return dateFormat
        .replaceFirst("yyyy", "$year")
        .replaceFirst("MM", "$month".padLeft(2, '0'))
        .replaceFirst("M", "$month")
        .replaceFirst("dd", "$day".padLeft(2, '0'))
        .replaceFirst("d", "$day")
        .replaceFirst("HH", "$hour".padLeft(2, '0'))
        .replaceFirst("H", "$hour")
        .replaceFirst("a", period)
        .replaceFirst("hh", "$hour12".padLeft(2, '0'))
        .replaceFirst("h", "$hour12")
        .replaceFirst("mm", "$minute".padLeft(2, '0'))
        .replaceFirst("m", "$minute")
        .replaceFirst("ss", "$second".padLeft(2, '0'))
        .replaceFirst("s", "$second");
  }
}
