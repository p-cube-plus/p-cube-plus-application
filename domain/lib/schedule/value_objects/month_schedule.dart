import 'package:domain/schedule/value_objects/schedule_type.dart';
import 'package:meta/meta.dart';

@immutable
class MonthSchedule {
  final ScheduleType type;
  final DateTime scheduleDate;
  const MonthSchedule({
    required this.type,
    required this.scheduleDate,
  });
}
