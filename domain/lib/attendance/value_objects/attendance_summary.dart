import 'package:domain/attendance/value_objects/attendance_status_type.dart';
import 'package:meta/meta.dart';

@immutable
class AttendanceSummary {
  final int maxWeekNumber; // 회의가 어느 요일인지 모르기 때문에 최대 주차를 알 수 없다.
  final List<AttendanceStatusType> statusList;
  const AttendanceSummary({
    required this.maxWeekNumber,
    required this.statusList,
  });
}
