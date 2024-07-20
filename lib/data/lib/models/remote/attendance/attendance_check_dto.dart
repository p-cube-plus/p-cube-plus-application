import 'package:data/utils/json_util.dart';

import 'attendance_dto.dart';
import 'attendance_state_dto.dart';

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
