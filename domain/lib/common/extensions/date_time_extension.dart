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
