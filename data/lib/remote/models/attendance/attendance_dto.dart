import 'package:domain/models/attendance/attendance_data.dart';

class AttendanceDTO {
  final int id;
  final String title;
  final DateTime startDate;
  final DateTime? endDate;

  AttendanceDTO({
    required this.id,
    required this.title,
    required this.startDate,
    required this.endDate,
  });

  factory AttendanceDTO.fromJson(Map<String, dynamic> json) {
    return AttendanceDTO(
      id: json['id'],
      title: json['title'],
      startDate: DateTime.parse("${json['start_date']} ${json['start_time']}"),
      endDate: DateTime.parse(json['end_date']),
    );
  }
}

extension AttendanceDTOExtension on AttendanceDTO {
  AttendanceData toDomain() {
    return AttendanceData(
      id: id,
      title: title,
      startDate: startDate,
      endDate: endDate,
    );
  }
}
