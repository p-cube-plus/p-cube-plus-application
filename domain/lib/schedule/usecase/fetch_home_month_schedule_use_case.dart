import 'package:domain/schedule/repository/schedule_repository.dart';
import 'package:domain/schedule/value_objects/month_schedule.dart';
import 'package:get_it/get_it.dart';

class FetchHomeMonthScheduleUseCase {
  final _scheduleRepository = GetIt.I.get<ScheduleRepository>();

  Future<Map<int, MonthSchedule>> call(int year, int month) async {
    final scheduleList =
        await _scheduleRepository.getScheduleListInMonth(year, month);
    final Map<int, MonthSchedule> scheduleMap = {};

    for (var schedule in scheduleList) {
      var startDate = schedule.startDate;
      if (startDate.month != month) {
        startDate = DateTime(year, month, 1);
      }

      var endDate = schedule.endDate;
      if (endDate.month != month) {
        endDate = DateTime(year, month + 1, 1).subtract(Duration(seconds: 1));
      }

      var currentDate = startDate;
      while (currentDate.isBefore(endDate)) {
        final day = currentDate.day;
        if (!scheduleMap.containsKey(day) ||
            schedule.startDate.isBefore(scheduleMap[day]!.scheduleDate)) {
          scheduleMap[day] = schedule.toMonthSchedule(currentDate);
        }
        currentDate =
            currentDate.copyWith(day: day + 1, hour: 0, minute: 0, second: 1);
      }
    }

    return scheduleMap;
  }
}
