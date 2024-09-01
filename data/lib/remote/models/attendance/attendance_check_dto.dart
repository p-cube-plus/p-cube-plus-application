import 'package:domain/models/attendance/attendance_check_data.dart';
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

extension AttendanceCheckDTOExtension on AttendanceCheckDTO {
  AttendanceCheckData toDomain() {
    return AttendanceCheckData(
      attendance: attendance.toDomain(),
      recordList: recordList.map((e) => e.toDomain()).toList(),
    );
  }
}
