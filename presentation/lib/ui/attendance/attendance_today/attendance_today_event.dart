sealed class AttendanceTodayEvent {}

class AttendanceTodayEventOnClickAttendance implements AttendanceTodayEvent {
  final int attendanceCount;
  AttendanceTodayEventOnClickAttendance(this.attendanceCount);
}
