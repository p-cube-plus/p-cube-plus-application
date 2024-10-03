import 'package:domain/attendance/value_objects/attendance_status_type.dart';
import 'package:domain/common/extensions/date_time_extension.dart';
import 'package:domain/common/extensions/string_extension.dart';
import 'package:meta/meta.dart';

@immutable
class AttendanceDao {
  final int id;
  final int sequenceNumber;
  final String _attendanceDateString;
  final int _attendanceStatusIndex;

  AttendanceDao({
    required this.id,
    required this.sequenceNumber,
    required DateTime attendanceDateTime,
    required AttendanceStatusType attendanceStatus,
  })  : _attendanceDateString = attendanceDateTime.format("yyyyMMddHHmmss"),
        _attendanceStatusIndex = attendanceStatus.index;

  AttendanceDao.fromStrings({
    required this.id,
    required this.sequenceNumber,
    required attendanceDateString,
    required attendanceStatusIndex,
  })  : _attendanceDateString = attendanceDateString,
        _attendanceStatusIndex = attendanceStatusIndex;

  DateTime get attendanceDateTime =>
      _attendanceDateString.toDateTime("yyyyMMddHHmmss");

  AttendanceStatusType get attendanceStatus =>
      AttendanceStatusType.fromIndex(_attendanceStatusIndex);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'sequenceNumber': sequenceNumber,
      'attendanceDateString': _attendanceDateString,
      'attendanceStatusIndex': _attendanceStatusIndex,
    };
  }

  factory AttendanceDao.fromMap(Map<String, dynamic> map) {
    return AttendanceDao.fromStrings(
      id: map['id'] as int,
      sequenceNumber: map['sequenceNumber'] as int,
      attendanceDateString: map['attendanceDateString'] as String,
      attendanceStatusIndex: map['attendanceStatusIndex'] as int,
    );
  }
}
