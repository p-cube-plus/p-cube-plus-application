import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:p_cube_plus_application/models/attendance.dart';
import 'package:p_cube_plus_application/utilities/json_util.dart';

@JsonSerializable()
class AttendanceCheck {
  final Attendance attendance;
  final List<AttendanceState> recordList;

  AttendanceCheck({
    required this.attendance,
    required this.recordList,
  });

  factory AttendanceCheck.fromJson(Map<String, dynamic> json) {
    return AttendanceCheck(
      attendance: json['attendance'],
      recordList: JsonUtil.instance.convertToList<AttendanceState>(
          AttendanceState.fromJson, json['record_list']),
    );
  }

  Map<String, dynamic> toJson() => {
        'attendance': attendance,
        'record_list': recordList,
      };
}

@JsonSerializable()
class AttendanceState {
  final DateTime date;
  final String state;

  AttendanceState({
    required this.date,
    required this.state,
  });

  factory AttendanceState.fromJson(Map<String, dynamic> json) {
    return AttendanceState(
      date: json['date'],
      state: json['state'],
    );
  }

  Map<String, dynamic> toJson() => {
        'date': DateFormat('yyyy-MM-dd').format(date),
        'state': state,
      };
}
