import 'package:domain/schedule/value_objects/schedule_data.dart';
import 'package:meta/meta.dart';

@immutable
class ScheduleDetail {
  final ScheduleData schedule;
  final String title;
  const ScheduleDetail({
    required this.schedule,
    required this.title,
  });
}
