extension DateTimeExtension on DateTime {
  bool isBetween(DateTime startDate, DateTime endDate) {
    return this.compareTo(startDate) >= 0 && this.compareTo(endDate) <= 0;
  }

  bool isMatchDay(DateTime date) {
    return this.year == date.year &&
        this.month == date.month &&
        this.day == date.day;
  }
}
