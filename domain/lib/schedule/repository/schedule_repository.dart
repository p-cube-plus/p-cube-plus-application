import 'package:domain/schedule/value_objects/schedule_data.dart';
import 'package:domain/schedule/value_objects/schedule_detail.dart';

abstract interface class ScheduleRepository {
  Future<List<ScheduleData>> getScheduleListInMonth(
    int year,
    int month,
  );

  Future<List<ScheduleDetail>> getUpcommingScheduleDetailList();
  Future<List<ScheduleDetail>> getDailyScheduleDetailList(DateTime date);
}
