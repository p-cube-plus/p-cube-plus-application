import 'package:domain/models/attendance/attendance_state_data.dart';

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

extension AttendanceStateDTOExtension on AttendanceStateDTO {
  AttendanceStateData toDomain() {
    return AttendanceStateData(
      date: date,
      state: state,
    );
  }
}
