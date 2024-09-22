import 'package:domain/common/value_objects/color.dart';
import 'package:domain/schedule/value_objects/schedule_type.dart';
import 'package:meta/meta.dart';

@immutable
class ScheduleData {
  final ScheduleType type;
  final DateTime startDate;
  final DateTime endDate;

  const ScheduleData({
    required this.type,
    required this.startDate,
    required this.endDate,
  });

  bool get isDailySchedule =>
      startDate.year == endDate.year &&
      startDate.month == endDate.month &&
      startDate.day == endDate.day;

  Color get markColor {
    return [
      Color(0xDE2B13),
      Color(0x5EDCA7),
      Color(0x4813DE),
    ][type.index];
  }
}
