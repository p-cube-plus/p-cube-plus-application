import 'schedule_type.dart';

class UpcommingScheduleData {
  ScheduleType scheduleType;
  DateTime startDate;
  DateTime? endDate;
  String title;

  UpcommingScheduleData({
    required this.scheduleType,
    required this.startDate,
    this.endDate,
    required this.title,
  });
}
