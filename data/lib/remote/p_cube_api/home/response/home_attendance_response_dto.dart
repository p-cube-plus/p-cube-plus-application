import 'dart:ui';

import 'package:domain/attendance/value_objects/home_attendance.dart';

class HomeAttendanceResponseDTO {
  final int id;
  final String title;
  final DateTime startDate;
  final DateTime? endDate;

  HomeAttendanceResponseDTO({
    required this.id,
    required this.title,
    required this.startDate,
    required this.endDate,
  });

  factory HomeAttendanceResponseDTO.fromJson(Map<String, dynamic> json) {
    return HomeAttendanceResponseDTO(
      id: json['id'],
      title: json['title'],
      startDate: DateTime.parse("${json['start_date']} ${json['start_time']}"),
      endDate: DateTime.parse(json['end_date']),
    );
  }
}

extension HomeAttendanceResponseDTOExtension on HomeAttendanceResponseDTO {
  HomeAttendance toDomain() {
    return HomeAttendance(
      id: id,
      attendanceDate: startDate,
      scheduleTypeColor: Color(0xFFFFFFFF),
      title: title,
    );
  }
}
