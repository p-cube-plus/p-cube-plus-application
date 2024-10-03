import 'package:domain/schedule/repository/schedule_repository.dart';
import 'package:domain/schedule/value_objects/daily_schedule.dart';
import 'package:get_it/get_it.dart';

class FetchHomeMonthScheduleUseCase {
  final _scheduleRepository = GetIt.I.get<ScheduleRepository>();

  Future<Map<int, DailySchedule>> call(int year, int month) async {
    final scheduleList =
        await _scheduleRepository.getScheduleListInMonth(year, month);
    final Map<int, DailySchedule> scheduleMap = {};

    for (var schedule in scheduleList) {
      var startDate = schedule.startDate;
      if (schedule.startDate.month != month) {
        startDate = DateTime(year, month, 1);
      }

      var currentDate = startDate;
      while (currentDate.isBefore(schedule.endDate)) {
        final day = currentDate.day;
        if (!scheduleMap.containsKey(day) ||
            scheduleMap[day]!.scheduleDate.isBefore(schedule.startDate)) {}
        {
          scheduleMap[day] = schedule.toOngoingDailySchedule(currentDate);
        }
        currentDate =
            currentDate.copyWith(day: day + 1, hour: 0, minute: 0, second: 1);
      }
    }

    return scheduleMap;
  }
}
