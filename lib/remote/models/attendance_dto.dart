import 'package:p_cube_plus_application/remote/utils/json_util.dart';

class AttendanceCheckDTO {
  final AttendanceDTO attendance;
  final List<AttendanceStateDTO> recordList;

  const AttendanceCheckDTO({
    required this.attendance,
    required this.recordList,
  });

  factory AttendanceCheckDTO.fromJson(Map<String, dynamic> json) {
    return AttendanceCheckDTO(
      attendance: json['attendance'],
      recordList: JsonUtil().convertToList<AttendanceStateDTO>(
          AttendanceStateDTO.fromJson, json['record_list']),
    );
  }
}

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

class AttendanceDTO {
  final int id;
  final String title;
  final DateTime startDate;
  final DateTime startTime;
  final DateTime? endDate;

  AttendanceDTO({
    required this.id,
    required this.title,
    required this.startDate,
    required this.startTime,
    required this.endDate,
  });

  factory AttendanceDTO.fromJson(Map<String, dynamic> json) {
    return AttendanceDTO(
      id: json['id'],
      title: json['title'],
      startDate: DateTime.parse(json['start_date']),
      startTime: DateTime.parse(json['start_time']),
      endDate: DateTime.parse(json['end_date']),
    );
  }
}
