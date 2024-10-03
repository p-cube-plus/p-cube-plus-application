import 'package:domain/schedule/value_objects/schedule_data.dart';

abstract interface class ScheduleRepository {
  Future<List<ScheduleData>> getScheduleListInMonth(
    int year,
    int month,
  );

  Future<List<ScheduleData>> getUpcommingScheduleDetailList();
  Future<List<ScheduleData>> getDailyScheduleDetailList(DateTime date);
}
