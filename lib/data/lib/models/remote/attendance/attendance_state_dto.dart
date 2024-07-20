class AttendanceStateDTO {
  final DateTime date;
  final String state;

  AttendanceStateDTO({
    required this.date,
    required this.state,
  });

  factory AttendanceStateDTO.fromJson(Map<String, dynamic> json) {
    return AttendanceStateDTO(
      date: json['date'],
      state: json['state'],
    );
  }
}
