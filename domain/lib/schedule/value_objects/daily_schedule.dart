import 'package:domain/schedule/value_objects/schedule_type.dart';
import 'package:meta/meta.dart';

@immutable
class DailySchedule {
  final String title;
  final ScheduleType type;
  final DateTime scheduleDate;
  const DailySchedule({
    required this.title,
    required this.type,
    required this.scheduleDate,
  });
}
