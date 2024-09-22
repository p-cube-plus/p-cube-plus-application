import 'package:domain/attendance/value_objects/today_attendance.dart';

sealed class AttendanceTodayEvent {}

class AttendanceTodayEventOnClickAttendance implements AttendanceTodayEvent {
  final TodayAttendance data;
  AttendanceTodayEventOnClickAttendance(this.data);
}

class CheckTimeToCanAttendance implements AttendanceTodayEvent {
  final List<TodayAttendance> data;
  CheckTimeToCanAttendance(this.data);
}
