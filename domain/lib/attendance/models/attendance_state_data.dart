class AttendanceStateData {
  final DateTime date;
  final String state;

  AttendanceStateData({
    required this.date,
    required this.state,
  });

  factory AttendanceStateData.fromJson(Map<String, dynamic> json) {
    return AttendanceStateData(
      date: json['date'],
      state: json['state'],
    );
  }
}
