import 'package:domain/common/value_objects/color.dart';
import 'package:meta/meta.dart';

import 'attendance_data.dart';

@immutable
class HomeAttendance {
  final AttendanceData attendanceData;
  final Color scheduleTypeColor;
  final String title;
  const HomeAttendance({
    required this.attendanceData,
    required this.scheduleTypeColor,
    required this.title,
  });
}
