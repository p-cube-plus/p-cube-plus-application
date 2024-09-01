class HomeCalendarScheduleData {
  final int id;
  final int? type;
  final String title;
  final DateTime startDate;
  final String? startTime;
  final DateTime? endDate;

  // Color getMarkColor() {
  //   return [Color(0xCCDE2B13), Color(0xFF5EDCA7), Color(0xCC4813DE)][type ?? 0];
  // }

  HomeCalendarScheduleData({
    required this.id,
    required this.type,
    required this.title,
    required this.startDate,
    required this.startTime,
    required this.endDate,
  });
}
