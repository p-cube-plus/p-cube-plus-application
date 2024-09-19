import 'package:color/color.dart';
import 'package:meta/meta.dart';

@immutable
class HomeAttendance {
  final int id;
  final DateTime attendanceDate;
  final Color scheduleTypeColor;
  final String title;
  const HomeAttendance({
    required this.id,
    required this.attendanceDate,
    required this.scheduleTypeColor,
    required this.title,
  });
}
