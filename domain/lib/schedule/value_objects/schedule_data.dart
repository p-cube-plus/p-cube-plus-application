import 'package:domain/schedule/value_objects/daily_schedule.dart';
import 'package:domain/schedule/value_objects/schedule_type.dart';
import 'package:meta/meta.dart';

@immutable
class ScheduleData {
  final String title;
  final ScheduleType type;
  final DateTime startDate;
  final DateTime endDate;
  const ScheduleData({
    required this.title,
    required this.type,
    required this.startDate,
    required this.endDate,
  });

  DailySchedule toStartDailySchedule() {
    return DailySchedule(
      title: "$title 시작",
      type: type,
      scheduleDate: startDate,
    );
  }

  DailySchedule toOngoingDailySchedule(DateTime onGoingDay) {
    return DailySchedule(
      title: "$title 진행중",
      type: type,
      scheduleDate: onGoingDay.copyWith(hour: 0, minute: 0, second: 1),
    );
  }

  DailySchedule toEndDailySchedule() {
    return DailySchedule(
      title: "$title 종료",
      type: type,
      scheduleDate: endDate,
    );
  }
}
