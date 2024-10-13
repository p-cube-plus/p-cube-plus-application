import 'package:data/utils/json_util.dart';

class AttendanceCheckResponseDTO {
  final AttendanceDTO attendance;
  final List<AttendanceStateDTO> recordList;

  const AttendanceCheckResponseDTO({
    required this.attendance,
    required this.recordList,
  });

  factory AttendanceCheckResponseDTO.fromJson(Map<String, dynamic> json) {
    return AttendanceCheckResponseDTO(
      attendance: json['attendance'],
      recordList: JsonUtil().convertToList<AttendanceStateDTO>(
          AttendanceStateDTO.fromJson, json['record_list']),
    );
  }
}

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
      // 출석(초록원), 지각(노랑원), 왕지각(빨강X), 불참(빈 원), (아직 출석 안 함),
      state: json['state'],
    );
  }
}
