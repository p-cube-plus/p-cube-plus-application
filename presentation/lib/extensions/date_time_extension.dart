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
