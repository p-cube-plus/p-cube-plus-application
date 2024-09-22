import 'package:domain/schedule/repository/schedule_repository.dart';
import 'package:domain/schedule/value_objects/schedule_data.dart';
import 'package:get_it/get_it.dart';

class FetchHomeMonthScheduleUseCase {
  final _scheduleRepository = GetIt.I.get<ScheduleRepository>();

  Future<Map<int, ScheduleData>> call(int year, int month) async {
    final scheduleList =
        await _scheduleRepository.getScheduleListInMonth(year, month);
    final Map<int, ScheduleData> scheduleMap = {};

    for (int i = 0; i < scheduleList.length; ++i) {
      final schedule = scheduleList[i];
      final startDay = schedule.startDate.day;

      if (scheduleMap.containsKey(startDay) &&
          scheduleMap[startDay]!.startDate.isAfter(schedule.startDate)) {
        continue;
      }

      scheduleMap[startDay] = schedule;
    }

    return scheduleMap;
  }
}
